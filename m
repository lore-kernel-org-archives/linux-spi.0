From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [patch 7/9] ANUBIS: Add SM501 GPIO and update
	I2C setup
Date: Fri, 10 Oct 2008 11:03:51 +0100
Message-ID: <20081010100406.526119389@fluff.org.uk>
References: <20081010100344.572052114@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline;
	filename=simtec/simtec-mach-anubis-update-sm501-gpio.patch
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Add GPIO support to the SM501 on the Simtec Anubis,
and then add the necessary updates for allowing the
two gpio I2C busses to be used.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux-2.6.26-rc8-quilt3/arch/arm/mach-s3c2440/mach-anubis.c
===================================================================
--- linux-2.6.26-rc8-quilt3.orig/arch/arm/mach-s3c2440/mach-anubis.c	2008-07-02 14:56:08.000000000 +0100
+++ linux-2.6.26-rc8-quilt3/arch/arm/mach-s3c2440/mach-anubis.c	2008-07-02 15:44:23.000000000 +0100
@@ -367,6 +367,8 @@ static struct sm501_initdata anubis_sm50
 		.mask	= 0,
 	},
 
+	.devices	= SM501_USE_GPIO,
+
 	/* set the SDRAM and bus clocks */
 	.mclk		= 72 * MHZ,
 	.m1xclk		= 144 * MHZ,
@@ -374,10 +376,12 @@ static struct sm501_initdata anubis_sm50
 
 static struct sm501_platdata_gpio_i2c anubis_sm501_gpio_i2c[] = {
 	[0] = {
+		.bus_num	= 1,
 		.pin_scl	= 44,
 		.pin_sda	= 45,
 	},
 	[1] = {
+		.bus_num	= 2,
 		.pin_scl	= 40,
 		.pin_sda	= 41,
 	},
@@ -385,6 +389,7 @@ static struct sm501_platdata_gpio_i2c an
 
 static struct sm501_platdata anubis_sm501_platdata = {
 	.init		= &anubis_sm501_initdata,
+	.gpio_base	= -1,
 	.gpio_i2c	= anubis_sm501_gpio_i2c,
 	.gpio_i2c_nr	= ARRAY_SIZE(anubis_sm501_gpio_i2c),
 };

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
