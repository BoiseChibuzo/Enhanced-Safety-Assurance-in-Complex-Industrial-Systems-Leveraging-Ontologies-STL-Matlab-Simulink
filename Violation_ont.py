import os
import xml.etree.ElementTree as ET
from rdflib import Graph, Literal, BNode, Namespace, RDF

# Corrected XML data
xml_data = '''<?xml version="1.0" encoding="utf-8"?>
<Violations>
    <Violation>
        <Parameter>Reactor Pressure Alt1</Parameter>
        <Formula>ev (reactorPressure[t] &gt; 3000)</Formula>
    </Violation>
    <Violation>
        <Parameter>Reactor Pressure Alt2</Parameter>
        <Formula>alw (reactorPressure[t] &gt; 2800 and reactorPressure[t] &lt; 2900)</Formula>
    </Violation>
    <Violation>
        <Parameter>Reactor Level</Parameter>
        <Formula>alw (reactorLevel[t] &gt; 50) and alw(reactorLevel[t] &lt; 100)</Formula>
    </Violation>
    <Violation>
        <Parameter>Reactor Level Alt1</Parameter>
        <Formula>ev (reactorLevel[t] &lt; 45)</Formula>
    </Violation>
    <Violation>
        <Parameter>Reactor Level Alt2</Parameter>
        <Formula>alw (reactorLevel[t] &lt;= 105)</Formula>
    </Violation>
    <Violation>
        <Parameter>Reactor Temperature</Parameter>
        <Formula>alw (reactorTemperature[t] &lt; 150)</Formula>
    </Violation>
    <Violation>
        <Parameter>Reactor Temperature Alt</Parameter>
        <Formula>alw (reactorTemperature[t] &gt; 120 and reactorTemperature[t] &lt; 150)</Formula>
    </Violation>
    <Violation>
        <Parameter>Stripper Level</Parameter>
        <Formula>alw (stripperLevel[t] &gt; 30) and alw(stripperLevel[t] &lt; 100)</Formula>
    </Violation>
    <Violation>
        <Parameter>Stripper Level Alt1</Parameter>
        <Formula>alw (stripperLevel[t] &gt;= 25)</Formula>
    </Violation>
    <Violation>
        <Parameter>Stripper Level Alt2</Parameter>
        <Formula>ev (stripperLevel[t] &gt; 105)</Formula>
    </Violation>
</Violations>'''

# Load the XML into an ElementTree
root = ET.fromstring(xml_data)

# Create a new RDF graph
g = Graph()

# Define a namespace for our ontology
n = Namespace("http://example.org/ontology/")

# Loop through each violation in the XML
for violation in root.findall('.//Violation'):  # Corrected XPath to find Violation elements
    # Create a new blank node for each violation
    v_node = BNode()

    # Get parameter and formula from the XML
    parameter = violation.find('Parameter').text
    formula = violation.find('Formula').text

    # Add triples to the graph
    g.add((v_node, RDF.type, n.Violation))
    g.add((v_node, n.hasParameter, Literal(parameter)))
    g.add((v_node, n.hasFormula, Literal(formula)))

# Define the file path for saving the RDF/XML file in the current directory
file_path = 'violations.rdf'  # Saving in the current directory

# Serialize and save the RDF graph to a file in RDF/XML format
g.serialize(destination=file_path, format='xml')

print(f'RDF data saved to {file_path}')
