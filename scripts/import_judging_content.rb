#!/usr/bin/env ruby

require "fileutils"
require "pathname"

SOURCE_REPO = "https://github.com/vadika/k9-SAR-judging".freeze

def yaml_escape(value)
  value.to_s.gsub("'", "''")
end

def extract_title_and_body(text, fallback_title)
  lines = text.lines
  heading_index = lines.index { |line| line.start_with?("# ") }
  return [fallback_title, text] unless heading_index

  title = lines[heading_index].sub(/^#\s+/, "").strip
  body_lines = lines[(heading_index + 1)..] || []
  body_lines.shift while body_lines.first&.strip == ""
  [title, body_lines.join]
end

def extract_subtopics(body)
  body.lines
      .map(&:strip)
      .select { |line| line.start_with?("## ") }
      .map { |line| line.sub(/^##\s+/, "").strip }
      .reject(&:empty?)
      .first(4)
end

def group_info(relative_path)
  return ["overview", "Overview", 0, "KP"] if relative_path == "JUDGE_KEY_POINTS.md"
  return ["judge", "Judge View", 8, "J08"] if relative_path == "judge/ABBREVIATIONS.md"

  base = File.basename(relative_path, ".md")
  number = base[/^\d+/].to_i
  label = format("%02d", number)

  if relative_path.start_with?("judge/")
    return ["judge", "Judge View", number, "J#{label}"]
  end

  if number <= 14
    ["obedience", "Obedience & Dexterity", number, label]
  else
    ["nosework", "Nosework & Alerts", number, label]
  end
end

def slug_for(relative_path)
  return "judges-key-points" if relative_path == "JUDGE_KEY_POINTS.md"

  base = File.basename(relative_path, ".md")
  base.sub(/^\d+_/, "").tr("_", "-").downcase
end

def write_imported_markdown(destination_path, metadata, body)
  subtopics_yaml = if metadata[:subtopics].any?
    metadata[:subtopics].map { |item| "- '#{yaml_escape(item)}'" }.join("\n")
  else
    "[]"
  end

  front_matter = <<~YAML
---
layout: judging_entry
title: '#{yaml_escape(metadata[:title])}'
permalink: /judging/#{metadata[:slug]}/
judging_group: #{metadata[:group]}
judging_group_label: '#{yaml_escape(metadata[:group_label])}'
judging_order: #{metadata[:order]}
judging_ref: '#{metadata[:reference]}'
source_repo: '#{SOURCE_REPO}'
source_path: '#{metadata[:source_path]}'
source_url: '#{SOURCE_REPO}/blob/main/#{metadata[:source_path]}'
judging_subtopics:
#{subtopics_yaml}
---

  YAML

  File.write(destination_path, front_matter + body.strip + "\n")
end

source_root = Pathname(ARGV[0] || ENV["JUDGING_SOURCE_DIR"] || abort("usage: #{File.basename($PROGRAM_NAME)} SOURCE_DIR [DEST_DIR]")).expand_path
destination_root = Pathname(ARGV[1] || "_judging").expand_path

unless source_root.directory?
  abort("source directory not found: #{source_root}")
end

FileUtils.rm_rf(destination_root)
FileUtils.mkdir_p(destination_root)

files = ["JUDGE_KEY_POINTS.md"] + Dir.glob(source_root.join("exercises/*.md")).sort.map { |path| Pathname(path).relative_path_from(source_root).to_s }
files += Dir.glob(source_root.join("judge/*.md")).sort.map { |path| Pathname(path).relative_path_from(source_root).to_s }

files.each do |relative_path|
  source_path = source_root.join(relative_path)
  fallback_title = File.basename(relative_path, ".md").tr("_", " ")
  title, body = extract_title_and_body(source_path.read, fallback_title)
  subtopics = extract_subtopics(body)
  group, group_label, order, reference = group_info(relative_path)
  slug = slug_for(relative_path)

  write_imported_markdown(
    destination_root.join("#{slug}.md"),
    {
      title: title,
      slug: slug,
      group: group,
      group_label: group_label,
      order: order,
      reference: reference,
      source_path: relative_path,
      subtopics: subtopics
    },
    body
  )
end

puts "Imported #{files.size} judging documents into #{destination_root}"
