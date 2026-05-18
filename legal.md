---
layout: indication
title: "Legal & business information — WorkingDog.fi"
description: "Business name, Y-tunnus, domicile, and contact details for Workingdog Nordic — the Finnish sole trader behind workingdog.fi."
lang: en
region: FI
permalink: /legal/
og_title: "Legal & business information"
og_description: "Workingdog Nordic — Y-tunnus 3624536-8, Tampere, Finland."
---

<main class="page">

  <section class="card">
    <h2>Legal &amp; business information</h2>
    <hr class="rule">
    <dl class="defs">
      <div class="row"><dt>Business name</dt><dd>{{ site.business.name }}</dd></div>
      <div class="row"><dt>Y-tunnus</dt><dd>{{ site.business.id }}</dd></div>
      <div class="row"><dt>Form</dt><dd>{{ site.business.form }}</dd></div>
      <div class="row"><dt>Domicile</dt><dd>{{ site.business.domicile }}</dd></div>
      <div class="row"><dt>Line of business</dt><dd>{{ site.business.toimiala }}</dd></div>
      <div class="row"><dt>Operator</dt><dd>{{ site.author.name }}</dd></div>
      <div class="row"><dt>Email</dt><dd><a href="mailto:{{ site.author.email }}">{{ site.author.email }}</a></dd></div>
      <div class="row"><dt>Phone</dt><dd><a href="tel:{{ site.author.phone | replace: ' ', '' }}">{{ site.author.phone }}</a></dd></div>
      <div class="row"><dt>Website</dt><dd><a href="{{ '/' | absolute_url }}">workingdog.fi</a></dd></div>
      <div class="row"><dt>Governing law</dt><dd>Finnish law. Disputes settled in the District Court of Pirkanmaa.</dd></div>
    </dl>
  </section>

</main>
