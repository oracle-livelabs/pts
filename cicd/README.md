Join our in-depth workshop to master creating OCI (Oracle Cloud Infrastructure) projects from scratch. This session will guide you through each essential step:

1. Create a Project: Start by setting up a new OCI project through the OCI console.
   
2. Set Up Code Repository: Configure your code repository and download the Todo App code sample.

3. Deploy Kubernetes Cluster: Use the wizard to create an Oracle Kubernetes Engine (OKE) cluster with default settings.

4. Create an Autonomous Database: Set up an Autonomous Database with default configurations. Download and replace the wallet, upload sample data, and update the configuration file.

5. Build Pipeline Creation: 
   - Name your Build Pipeline.
   - Add stages to create and push Docker images and Kubernetes manifests.
   - Configure artifacts for Docker images and Kubernetes manifests, linking them to build results.

6. Environment Setup: Define an Oracle Kubernetes Engine environment for use in the deploy pipeline.

7. Deploy Pipeline Creation:
   - Name your Deploy Pipeline.
   - Add a stage to apply Kubernetes manifests.
   - Configure the pipeline to use the previously created OKE environment and cluster.

8. Trigger Deployment: Link your Build Pipeline to the Deploy Pipeline to automate deployment triggers.

9. Run and Monitor: Execute the Build Pipeline manually, monitor both the build and deploy processes to ensure successful execution.

10. Access the Application:
    - Retrieve your application’s URL from the OKE cluster details.
    - Use Cloud Shell to access and monitor Kubernetes resources.
    - Copy the LoadBalancer’s External IP, append port 5000, and browse to view your deployed Todo App.

This workshop will provide hands-on experience with OCI, covering project creation, database setup, CI/CD pipeline management, and application deployment. Perfect for those looking to gain practical skills in OCI environments.
