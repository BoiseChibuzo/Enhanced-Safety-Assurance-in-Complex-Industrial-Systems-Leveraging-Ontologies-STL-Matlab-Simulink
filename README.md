# Strengthening  Safety Assurance in Complex Industrial Systems: Integrating Ontology's and Signal Temporal Logic for Enhanced Risk Management
## Brief Summary:
This repo contains the result files, Matlab scripts - both the ones that gave us the correct resutls and those that gave us not so good a result. Some of the generated figures are here.
Also, we included the ontology files we worked with, which is the Eastman Tennessee plant's ontology that we designed - which may not be as perfect and complete as in the original model. However, the ontology was for the purpose of the experiments we conducted in this paper. Note that some figures have been altered in the course of the experiments where we changed a lot of Thresholds and Set points back and forth for to test the violations monitoring system we developed.

This repo is where we put the artifacts from our experiments described in our paper - Enhanced Safety Assurance in Complex Industrial Systems: Leveraging Ontologies, Signal Temporal Logic(STL), and Matlab Simulink for Effective Boundary Violation Detection
Welcome to the Boundary Violation Experiments repository. This guide will walk you through the process of running Matlab scripts for simulation monitoring and converting XML log files into ontology files for further analysis.

##Prerequisites
Ensure you have the following setup on your system before proceeding:

Matlab (Version 2020a or later is recommended)
Required Matlab toolboxes (if any specific ones are needed)
An XML to ontology conversion tool (specify the tool if there's a recommended one)
Setup Instructions
Clone this repository to your local machine using the command:

```
git clone https://Enhanced-Safety-Assurance-in-Complex-Industrial-Systems-Leveraging-Ontologies-STL-Matlab-Simulink.git
Change your working directory to the cloned repository:
```

cd boundary-violation-experiments
Running Matlab Scripts
To execute the Matlab scripts, follow these steps:

Launch Matlab and navigate to the boundary-violation-experiments directory.

Set the current directory in Matlab to where the scripts are located.

Open the XML_SimulationMonitoring.m script in Matlab's editor.

Run the script by pressing F5 or clicking the "Run" button in the editor. Ensure to configure any necessary script parameters beforehand.

 ## Converting XML to Ontology Files
After running the Matlab simulation, you'll need to convert the generated XML log files into ontology files:

Verify that the XML log files are present in the specified output directory.

Run the Violation_ont.py file to convert the XML file to RDF

Then use Protege to open the ontology file for analysis
Execute the conversion process. The command might look something like this, depending on your tool:



## Additional Notes
After conversion, review the ontology files to ensure the data is correctly formatted and complete.

Use these ontology files for your subsequent data analysis or research needs.

## Troubleshooting
If you encounter issues:

Check Matlab's command window for errors and ensure all prerequisites are properly installed.

For conversion tool issues, verify the tool's configuration and ensure the XML files are not corrupted.

Support
For further assistance or to report a problem, please open an issue in this repository or contact the project maintainer directly.
