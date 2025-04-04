<!--
Copyright (c) 2025 Oracle and/or its affiliates.

The Universal Permissive License (UPL), Version 1.0

Subject to the condition set forth below, permission is hereby granted to any
person obtaining a copy of this software, associated documentation and/or data
(collectively the "Software"), free of charge and under any and all copyright
rights in the Software, and any and all patent rights owned or freely
licensable by each licensor hereunder covering either (i) the unmodified
Software as contributed to or provided by such licensor, or (ii) the Larger
Works (as defined below), to deal in both

(a) the Software, and
(b) any piece of software and/or hardware listed in the lrgrwrks.txt file if
one is included with the Software (each a "Larger Work" to which the Software
is contributed by such licensors),

without restriction, including without limitation the rights to copy, create
derivative works of, display, perform, and distribute the Software and make,
use, sell, offer for sale, import, export, have made, and have sold the
Software and the Larger Work(s), and to sublicense the foregoing rights on
either these or other terms.

This license is subject to the following condition:
The above copyright notice and either this complete permission notice or at
a minimum a reference to the UPL must be included in all copies or
substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
-->

# Example function to copy a file from an Object Storage bucket to multiple other buckets when uploaded

Reviewed: 31.10.2024
 
# When to use this asset?
 
Anyone who wants to implement content distribution in Object Storage buckets across multiple regions. This function is triggered by the upload CloudEvent of the source bucket and then copies the received file to multiple (1-n) other buckets that are replicated to other regions using the Object Storage buckets automatic replication feature. This way we can implement content distribution in  Object Storage buckets across multiple regions.

# Author
<a href="https://github.com/mikarinneoracle">mikarinneoracle</a>

# How to use this asset?

## Function configuration

<img src="files/config.png" width="800">
<ul>
<li><code>TENANCY</code> is the tenancy os namespace name e.g. what you get when running <code>oci os ns get</code></li>
<li><code>SOURCE_BUCKET</code> is the bucket where the file is uploaded and triggers this function using a CloudEvent</li>
<li><code>TARGET_BUCKETS</code> are the comma delimited buckets to where the file is copied from the source bucket are replicatyed to other regions using the Object Storage replication feature</li>
</ul>

<h3>Function example log when triggered by the Object Storage file upload (create/update) CloudEvent</h3>
<img src="files/log.png" width="800">

# Useful Links
 
- [OCI Functions](https://docs.oracle.com/en-us/iaas/Content/Functions/Concepts/functionsoverview.htm)
    - Learn how the Functions service lets you create, run, and scale business logic without managing any infrastructure
- [OCI SDK for JavaScript](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/typescriptsdk.htm)
    - The Oracle Cloud Infrastructure SDK for TypeScript and JavaScript enables you to write code to manage Oracle Cloud Infrastructure resources
- [Oracle](https://www.oracle.com/)
    - Oracle Website

### License

Copyright (c) 2025 Oracle and/or its affiliates.

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](https://github.com/oracle-devrel/technology-engineering/blob/main/LICENSE) for more details.
    
