-- macros/generate_schema_name.sql
-- Override dbt's default schema naming logic.
-- Production: use the custom schema name exactly (e.g., STAGING, FINANCE).
-- Dev/CI:     prefix with the target schema (e.g., dev_zoty_staging, ci_abc123_finance).

{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}

    {%- if custom_schema_name is none -%}
        {{- default_schema -}}

    {%- elif target.name == 'prod' -%}
        {# Production: use the custom schema name exactly as defined in dbt_project.yml #}
        {{- custom_schema_name | trim -}}

    {%- else -%}
        {# Dev / CI: prefix with the developer/CI schema to guarantee isolation #}
        {{- default_schema }}_{{ custom_schema_name | trim -}}

    {%- endif -%}

{%- endmacro %}