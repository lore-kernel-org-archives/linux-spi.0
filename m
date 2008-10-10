From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [patch 3/9] arch/arm/mach-s3c2410/pm.c: fix
	sparse warnings
Date: Fri, 10 Oct 2008 11:03:47 +0100
Message-ID: <20081010100405.220798105@fluff.org.uk>
References: <20081010100344.572052114@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline;
	filename=simtec/simtec-sparse-s3c24xx-s3c2410-pm.patch
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Do not use __raw_readl on straight pointers. Change the
code to using 'u32 *' as we are only accessing kernel
RAM using phys_to_virt() to find where it is.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux-2.6.27-rc6-quilt3/arch/arm/mach-s3c2410/pm.c
===================================================================
--- linux-2.6.27-rc6-quilt3.orig/arch/arm/mach-s3c2410/pm.c	2008-09-16 10:29:59.000000000 +0100
+++ linux-2.6.27-rc6-quilt3/arch/arm/mach-s3c2410/pm.c	2008-09-16 10:40:20.000000000 +0100
@@ -44,6 +44,11 @@ extern void pm_dbg(const char *fmt, ...)
 #define DBG(fmt...) printk(KERN_DEBUG fmt)
 #endif
 
+static inline void write_u32(u32 value, void *to)
+{
+	*(u32 *)to = value;
+}
+
 static void s3c2410_pm_prepare(void)
 {
 	/* ensure at least GSTATUS3 has the resume address */
@@ -54,35 +59,35 @@ static void s3c2410_pm_prepare(void)
 	DBG("GSTATUS4 0x%08x\n", __raw_readl(S3C2410_GSTATUS4));
 
 	if (machine_is_h1940()) {
-		void *base = phys_to_virt(H1940_SUSPEND_CHECK);
-		unsigned long ptr;
-		unsigned long calc = 0;
+		u32 *base = phys_to_virt(H1940_SUSPEND_CHECK);
+		unsigned  ptr;
+		u32 calc = 0;
 
 		/* generate check for the bootloader to check on resume */
 
-		for (ptr = 0; ptr < 0x40000; ptr += 0x400)
-			calc += __raw_readl(base+ptr);
+		for (ptr = 0; ptr < 0x40000/4; ptr += 0x400/4)
+			calc += base[ptr];
 
-		__raw_writel(calc, phys_to_virt(H1940_SUSPEND_CHECKSUM));
+		write_u32(calc, phys_to_virt(H1940_SUSPEND_CHECKSUM));
 	}
 
 	/* the RX3715 uses similar code and the same H1940 and the
 	 * same offsets for resume and checksum pointers */
 
 	if (machine_is_rx3715()) {
-		void *base = phys_to_virt(H1940_SUSPEND_CHECK);
-		unsigned long ptr;
-		unsigned long calc = 0;
+		u32 *base = phys_to_virt(H1940_SUSPEND_CHECK);
+		unsigned ptr;
+		u32 calc = 0;
 
 		/* generate check for the bootloader to check on resume */
 
-		for (ptr = 0; ptr < 0x40000; ptr += 0x4)
-			calc += __raw_readl(base+ptr);
+		for (ptr = 0; ptr < 0x40000/4; ptr += 0x4/4)
+			calc += base[ptr];
 
-		__raw_writel(calc, phys_to_virt(H1940_SUSPEND_CHECKSUM));
+		write_u32(calc, phys_to_virt(H1940_SUSPEND_CHECKSUM));
 	}
 
-	if ( machine_is_aml_m5900() )
+	if (machine_is_aml_m5900())
 		s3c2410_gpio_setpin(S3C2410_GPF2, 1);
 
 }
@@ -97,7 +102,7 @@ static int s3c2410_pm_resume(struct sys_
 	tmp &= S3C2410_GSTATUS2_OFFRESET;
 	__raw_writel(tmp, S3C2410_GSTATUS2);
 
-	if ( machine_is_aml_m5900() )
+	if (machine_is_aml_m5900())
 		s3c2410_gpio_setpin(S3C2410_GPF2, 0);
 
 	return 0;

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
