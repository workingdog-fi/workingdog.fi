# AGENTS.md

This file provides guidance to Codex (Codex.ai/code) when working with code in this repository.

## Project Overview

This is a Jekyll-based portfolio website for a SAR (Search and Rescue) Officer and Dog Handler. The site showcases professional experience, certifications, dog teams, and deployment history.

## Build and Deployment

The project uses GitHub Actions for automated building and deployment to GitHub Pages. The build process is triggered on:
- Pushes to the `main` branch
- Manual workflow dispatch

### Local Development Commands

```bash
# Install dependencies
bundle install

# Run local development server (http://localhost:4000)
bundle exec jekyll serve

# Build site locally
bundle exec jekyll build

# Clean build artifacts
bundle exec jekyll clean
```

## Architecture and Structure

### Data-Driven Content
The site uses YAML files in `_data/` to manage content:
- `certifications.yml` - Professional certifications
- `deployments.yml` - SAR deployment records  
- `dogs.yml` - SAR dog information
- `videos.yml` - Video content

### Component Structure
- `_includes/` - Reusable HTML components (header, certifications, dogs-team, etc.)
- `_layouts/` - Page layout templates
- `assets/css/` - Custom CSS with modern animations and gradients

### Key Technologies
- **Jekyll 4.3.0** - Static site generator
- **Ruby 3.1** - Build environment (used in GitHub Actions)
- **YAML** - Structured data format
- **GitHub Pages** - Hosting platform

## Important Configuration

**Note:** The config file is currently named `config.yml` but should be renamed to `_config.yml` for Jekyll to recognize it properly.

### GitHub Actions Workflow
Located at `.github/workflows/jekyll.yml`, the workflow:
1. Uses Ruby 3.1 with bundler caching
2. Builds with production environment
3. Automatically deploys to GitHub Pages

## Development Notes

When modifying content:
- Edit YAML files in `_data/` to update certifications, deployments, or dog information
- Modify includes in `_includes/` to change component appearance
- The site uses modern CSS features (backdrop-filter, animations) that may require fallbacks for older browsers