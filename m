From: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [Patch]Documentation/spi/spidev_test.c:
	constify some variables
Date: Sat, 6 Oct 2007 10:02:29 +0800
Message-ID: <20071006020229.GB2436@hacking>
Reply-To: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


Constify two char pointers and a struct in Documentation/spi/spidev_test.c.

CC: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
CC: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Signed-off-by: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
 Documentation/spi/spidev_test.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.23-rc9/Documentation/spi/spidev_test.c
===================================================================
--- linux-2.6.23-rc9.orig/Documentation/spi/spidev_test.c
+++ linux-2.6.23-rc9/Documentation/spi/spidev_test.c
@@ -29,7 +29,7 @@ static void pabort(const char *s)
 	abort();
 }
 
-static char *device = "/dev/spidev1.1";
+static const char *device = "/dev/spidev1.1";
 static uint8_t mode;
 static uint8_t bits = 8;
 static uint32_t speed = 500000;
@@ -69,7 +69,7 @@ static void transfer(int fd)
 	puts("");
 }
 
-void print_usage(char *prog)
+void print_usage(const char *prog)
 {
 	printf("Usage: %s [-DsbdlHOLC3]\n", prog);
 	puts("  -D --device   device to use (default /dev/spidev1.1)\n"
@@ -88,7 +88,7 @@ void print_usage(char *prog)
 void parse_opts(int argc, char *argv[])
 {
 	while (1) {
-		static struct option lopts[] = {
+		static const struct option lopts[] = {
 			{ "device",  1, 0, 'D' },
 			{ "speed",   1, 0, 's' },
 			{ "delay",   1, 0, 'd' },

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
