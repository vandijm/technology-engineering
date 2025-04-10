# GenAI-based Procurement Q&A App using Text-to-SQL and Low-Code Integration

Reviewed: 07.11.2024

# Introduction

In this article, we'll explore how to make a handy tool that helps to enable real-time purchase order feeds (updates, creations, etc.) coming from an ERP System (in this case Oracle ERP Cloud) into a procurement DB store and also to transform procurement queries in natural language to SQL Queries and synthesize the SQL Response using Oracle Generative AI, Oracle Integration Cloud (OIC) and Oracle Autonomous Database (ADB). 

This tool can be useful in different situations: for example, it could help Procurement Management Teams for better understanding of what's happenning with purchase orders sent to a supplier in near real-time, as well it could provide an easy to use UI for suppliers to know the status of payable invoices raised to a buyer, but these are only a few examples. It can be applied to other ERP documents like Payable Invoices, Receivables, etc., it is adaptable to Recruitment, CX Apps, as wel as it could be expanded to other customer query channels like social media platforms, web apps, etc.

<img src="./images/1_gen_ai_procurement_qa_app.png"></img>

<img src="./images/2_gen_ai_procurement_qa_app.png"></img>

<img src="./images/3_gen_ai_procurement_qa_app.png"></img>

<img src="./images/4_gen_ai_procurement_qa_app.png"></img>

# Prerequisites

Before getting started, make sure you have access to the following Oracle Cloud Infrastructure (OCI) services:

- OCI Generative AI
- Oracle Integration Cloud (OIC)
- Oracle Visual Builder (enabled under Oracle Integration Cloud)
- Oracle Autonomous Database (ATP)

And also, make sure you have access to the following Oracle SaaS Applications:

- Oracle Fusion ERP Cloud

# Solution Architecture

In this section, we'll dive into the building blocks of the solution architecture.

<img src="./images/5_oci-genai-procurement-qa-app-arch.png"></img>

We've built the solution using Oracle ERP Cloud business events (e.g. purchase order event, etc.) captured in real-time, and it smoothly runs through Oracle Integration Cloud as the main, low-code orchestration tool. OCI Generative AI is used to transform user's queries in natural language to SQL Queries as well as to synthesize the SQL Response, Oracle Autonomous Database is used to store the ERP data feeds and to execute the SQL Query generated by OCI Generative AI dynamically and an Oracle Visual Builder Cloud web app is configured to submit the query and visualize the SQL Response Records ans well as the generative ai-based synthesized answer in natural language:

1. Real-Time Capture of Oracle ERP Cloud business events using Oracle Integration Cloud's ERP Cloud native adapter:

- Oracle ERP Cloud Business Events (e.g. purchase order created/cancelled, payable invoice paid/void, etc.) can be captured in real-time via the Oracle ERP Cloud native adapter in Oracle Integration Cloud, triggering a producer and a consumer orchestration flow. This will help to querie the most up to date data from the ERP System (in this case Oracle ERP Cloud).

2. Guarantee the delivery of Oracle ERP Cloud Business Events with OCI Streaming Service:

- OCI Streaming (Oracle-managed Kafka service) deocuples Oracle ERP Cloud from the downstream applications/systems which will receive the procurement data feeds (in this case Oracle Autonomous Database), guarantees the delivery of procurement data messages to be further processed, and it can parallelize the processing of those data feeds.

3. Handling Procurement Data Feeds' History using Autonomous Database:

- For every procurement feed, we store it's data in Oracle Autonomous Database using the native adapter we have for it, so then we can have a text-to-sql LLM App in Oracle Visual Builder to do procurement queries in natural language on top of the Procurement DB Store

4. Query Text to SQL Transformation & Synthetized SQL Response with OCI Generative AI:

- The role of OCI Generative AI is to **transform the procurement query in natural language into a SQL Query** (which then is executed against the Procurement DB Store), and to **generate a synthesized answer** based on the SQL Response (which could be helpful to provide a friendly answer to the end user, for instance a procurement manager, etc.) 

5. Integration and orchestration using OIC:

- Oracle Integration Cloud adopts a low-code approach, allowing the creation of integrations and workflows with minimal coding effort and this accelerates the development process. OIC includes monitoring and analytics tools that provide real-time visibility into integration flows. This helps to track performance, identify bottlenecks, and change and optimize Generative AI service integration flows like the one we are exploring here

6. Connecting to the target destination apps/systems of the procurement data using Oracle Integration Cloud:

- Oracle Integration Cloud native adapters to different ERP Apps, Databases, Datawarehouses, and other downstream applications could be used to be able to store the po feeds data in target DBs/DWs, and others. 
In this case, we are using the native adapter to Oracle Autonomous Transaction Processing to store the procurement data in a staging relational DB, as well as to execute the generative ai-based SQL Query dynamically, and then to obtain a SQL Response, which in turn is synthesized by OCI Generative AI.

7. Text to SQL Procurement Q&A App interface built using VBCS:

- The “Procurement Q&A App” discussed in this context is crafted within the VBCS platform. Oracle Visual Builder Cloud Service (under Oracle Integration Cloud) serves as a hosted environment for building your application development infrastructure. It offers an open-source, standards-based development service for creating, collaborating on, and deploying applications within the Oracle Cloud.

# Solution Flow in Detail

In this solution:

**Step1.** Oracle ERP Cloud raises business event message notifications that let you watch for changes to ERP Entities like Purchase Orders, Payable Invoices, Journals, etc. You configure an integration user in Oracle Fusion ERP Cloud with the following ROLES assigned to it:

<img src="./images/6_oracle_erp_integration_user_roles.png"></img>

**Step2.** Every time a new procurement feed is created/updated, cancelled, etc., a business event message is sent to Oracle Integration Cloud via the Oracle ERP Cloud native adapter, triggering the **OIC ERP Cloud_PO_to_OCI_Streaming_PO_Stream Low-Code Integration Flow**, which in turn sends it to an OCI Streaming Kafka Topic for further processing.

<img src="./images/1_gen_ai_procurement_qa_app.png"></img>

<img src="./images/7_oic_erp_cloud_event_to_oci_streaming_integration.png"></img>

<img src="./images/8_oic_oracle_fusion_erp_cloud_connection.png"></img>

<img src="./images/7_oic_erp_cloud_event_to_oci_streaming_integration_1.png"></img>

<img src="./images/9_oci_streaming_po_stream.png"></img>

<img src="./images/10_oic_oci_streaming_connection.png"></img>

<img src="./images/7_oic_erp_cloud_event_to_oci_streaming_integration_2.png"></img>

**Step3.** After receiving the Oracle ERP Cloud procurement business event notification into the POStream Kafka Topic, the **OIC OCI_Streaming_PO_Stream_to ATP_PO_Tables Low-Code Integration Flow** is triggered. 

The procurement business event data is then stored in the Procurement DB Store. In this case, the Oracle Autonomous Database native adapter in Oracle Integration Cloud is used to achieve this part of the orchestration flow.

<img src="./images/11_oic_oci_streaming_to_atp_po_tables_integration.png"></img>
<img src="./images/11_oic_oci_streaming_to_atp_po_tables_integration_1.png"></img>
<img src="./images/12_oic_atp_connection.png"></img>
<img src="./images/11_atp_po_tables_0.png"></img>
<img src="./images/11_atp_po_tables_1.png"></img>
<img src="./images/11_atp_po_tables_2.png"></img>
<img src="./images/11_oic_oci_streaming_to_atp_po_tables_integration_2.png"></img>
<img src="./images/11_oic_oci_streaming_to_atp_po_tables_integration_3.png"></img>

<img src="./images/2_gen_ai_procurement_qa_app.png"></img>

**Step4.** At this step, Procurement Manager types a procurement query (input field) in VBCS Procurement Q&A LLM App.

<img src="./images/13_step1_oic_vbcs_input_search.png"></img>

**Step5.** Procurement Manager press the button "Search", which executes the Input Text On Value Change action.

<img src="./images/13_step2_oic_vbcs_search_button.png"></img>

<img src="./images/13_step2_oic_vbcs_search_button_action.png"></img>

**Step6.** After pressing the button Search, the user's query is processed via OCI Generative AI, triggering the **OIC REST_GenAI_Text_to_SQL_Oracle Integration Flow** (Query Text to SQL transformation and SQL Response Synthesize with OCI Generative REST API).

<img src="./images/14_oic_rest_text_to_sql_integration.png"></img>

**Step7.** At this step, the procurement db store table schemas are retrieved and then convert into a schema_string to be used in the text to sql prompt later on. In this case, the Oracle Autonomous Database native adapter in Oracle Integration Cloud is used to achieve this part of the orchestration flow.

<img src="./images/14_oic_rest_text_to_sql_integration_0.png"></img>

<img src="./images/14_oic_rest_text_to_sql_integration_10.png"></img>

<img src="./images/14_oic_rest_text_to_sql_integration_1.png"></img>

<img src="./images/14_oic_rest_text_to_sql_integration_2.png"></img>

**Step8.** At this step, using Generative AI the user's query in natural language is transformed to a SQL Query using prompting techniques, calling the Generative AI Inference REST API via Oracle Integration Cloud's REST Connector.

<img src="./images/14_oic_rest_text_to_sql_integration_3.png"></img>

<img src="./images/14_oic_rest_gen_ai_api_connection.png"></img>

<img src="./images/14_oic_rest_text_to_sql_integration_4.png"></img>

<img src="./images/14_oic_rest_text_to_sql_integration_5.png"></img>

<img src="./images/14_oic_rest_text_to_sql_integration_6.png"></img>

<img src="./images/3_gen_ai_procurement_qa_app.png"></img>

**Step9.** At this step, we dynamically execute the SQL Query generated in the previous step. In this case, the Oracle Autonomous Database native adapter in Oracle Integration Cloud is used to achieve this part of the orchestration flow.

<img src="./images/14_oic_rest_text_to_sql_integration_7.png"></img>

<img src="./images/14_oic_rest_text_to_sql_integration_10.png"></img>

<img src="./images/14_oic_rest_text_to_sql_integration_8.png"></img>

<img src="./images/14_oic_rest_text_to_sql_integration_9.png"></img>

**Step10.** At this step, using Generative AI the SQL Response is synthesized using prompting techniques, calling the Generative AI Inference REST API via Oracle Integration Cloud's REST Connector.

<img src="./images/14_oic_rest_text_to_sql_integration_11.png"></img>

<img src="./images/14_oic_rest_text_to_sql_integration_12.png"></img>

<img src="./images/14_oic_rest_text_to_sql_integration_13.png"></img>

**Step11.** The list of records from the Procurement DB Store are shown on the screen together with the synthesized SQL Response.

<img src="./images/4_gen_ai_procurement_qa_app.png"></img>

# Prompting with Oracle Generative AI

In the following GenAI-based Procurement Q&A App use case we are using a Generative AI Multi-Chain Prompting technique to get the results. It consists of 2 prompts:

**Important Note:** 
**All examples and data presented in this article are purely fictive and for showcasing purposes only. Any resemblance to real persons, or actual companies is purely coincidental. Dummy users and entities have been created for this demo, and no real data or information about individuals or organizations is being disclosed. We prioritize privacy and ethical considerations in the presentation of information, and any similarities to real-world entities are unintentional.**

## Prompt 1: Text to SQL Generation

To transform the user's query in natural language into a syntactically correct SQL Query, we have created a text-to-sql prompt using two combined techniques: **Few-shot Prompting** and **Chain-of-Thought Prompting**.

<img src="./images/3_gen_ai_procurement_qa_app.png"></img>

Please access the full prompt <a href="./images/GenAIProcurementQ&AAppPrompts.pdf">here</a>

## Prompt 2: SQL Response Synthesized Answer

To provide a synthesized answer in natural language based on the  SQL Response, we have created a prompt in a Zero-shot technique, where we explicitly mention the output we need.

<img src="./images/14_oic_rest_text_to_sql_integration_13.png"></img>

Please access the full prompt <a href="./images/GenAIProcurementQ&AAppPrompts.pdf">here</a>

# Code
      VBCS App - GenAIProcurementQA-1.0.zip
      OIC ERP Cloud_PO_to_OCI_Streaming_PO_Stream Low-Code Integration Flow - I37_08_01_01.00.0000.iar
      OIC OCI_Streaming_PO_Stream_to ATP_PO_Tables Low-Code Integration Flow - I37_08_01_ATP_PO_TABLE_01.00.0000.iar
      OIC REST_GenAI_Text_to_SQL_Oracle Integration Flow - REST_GENAI_TEXT_TO_SQL_ORACL_01.00.0000.iar
      Procurement Query Samples - procurement_query_test_samples.txt
      Procurement Q&A DB Store Table and SQL Procedure Scripts - genai_procurement_qa.sql
      Generative AI Prompts: GenAIProcurementQ&AAppPrompts.pdf

Please find the **gen_ai_procurement_qa_sol_resources** archive in <a href="./gen_ai_procurement_qa_sol_resources.zip">/files/gen_ai_procurement_qa_sol_resources.zip</a>

# Conclusion

In conclusion, using OCI Generative AI and Oracle Integration Cloud (OIC) you may build a nice solution that may sort and help to better understanding of what's happenning with procurement processes, processing queries from procurement users across various Email channels, Social Media Platforms, Web Apps, ERP systems, and DBs, etc. Its adaptability and ease of use can become a handy tool to help streamlining procurement processes by saving time, and helping enhance productivity across a wide range of business scenarios.

### Authors

<a href="https://github.com/jcgocol">@jcgocol</a>

# License
 
Copyright (c) 2025 Oracle and/or its affiliates.
 
Licensed under the Universal Permissive License (UPL), Version 1.0.
 
See [LICENSE](https://github.com/oracle-devrel/technology-engineering/blob/main/LICENSE) for more details.
	
