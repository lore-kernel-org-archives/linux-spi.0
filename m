From: Alexander Sverdlin <asv-uSbOeAmDUekAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] of/spi: Honour "status=disabled" property of device
Date: Thu, 29 Nov 2012 08:59:29 +0100
Message-ID: <50B715E1.3010501@sysgo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Barry.Song-kQvG35nSl+M@public.gmane.org,
 w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, alexander sverdlin <alexander.sverdlin.ext-OYasijW0DpE@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
 devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
 Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
 Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-spi.vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin-uSbOeAmDUekAvxtiuMwx3w@public.gmane.org>

of/spi: Honour "status=disabled" property of device

Currently of_register_spi_devices() function registers all SPI devices,
independetly from their status property in device tree. According to
"ePAPR 1.1" spec, device should only be registered if there is no
"status" property, or it has "ok" (or "okay") value (see
of_device_is_available()). In case of "platform devices",
of_platform_device_create_pdata() checks for "status" and ensures
that disabled devices are not pupulated. But such check for SPI buses
was missing until now. Fix it.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin-uSbOeAmDUekAvxtiuMwx3w@public.gmane.org>
---
--- linux.orig/drivers/spi/spi.c
+++ linux/drivers/spi/spi.c
@@ -819,7 +819,7 @@ static void of_register_spi_devices(stru
 	if (!master->dev.of_node)
 		return;
 
-	for_each_child_of_node(master->dev.of_node, nc) {
+	for_each_available_child_of_node(master->dev.of_node, nc) {
 		/* Alloc an spi_device */
 		spi = spi_alloc_device(master);
 		if (!spi) {
