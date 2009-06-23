From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.30] spi: new spi->mode bits
Date: Tue, 23 Jun 2009 12:07:37 -0700
Message-ID: <200906231207.37879.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Paulraj, Sandeep" <s-paulraj-l0cyMroinI0@public.gmane.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

Add two new spi_device.mode bits to accomodate more protocol
options, and pass them through to usermode drivers:

 * SPI_NO_CS ... a second 3-wire variant, where the chipselect
   line is removed instead of a data line; transfers are still
   full duplex.
   
   This obviously has STRONG protocol implications since the
   chipselect transitions can't be used to synchronize state
   transitions with the SPI master.

 * SPI_READY ... defines open drain signal that's pulled low
   to pause the clock.  This defines a 5-wire variant (normal
   4-wire SPI plus READY) and two 4-wire variants (READY plus
   each of the 3-wire flavors).
   
   Such hardware flow control can be a big win.  There are ADC
   converters and flash chips that expose READY signals, but not
   many host controllers support it today.

The spi_bitbang code should be changed to use SPI_NO_CS instead
of its current nonportable hack.  That's a mode most hardware
can easily support (unlike SPI_READY).

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
An upcoming driver for the SPI controller in some new DaVinci
family chips (the DA830/OMAP-L137) supports both these modes.

Yep, and later patches will add more spi_device.mode bits, now
that the existing set is all used up.

 Documentation/spi/spidev_test.c |   10 +++++++++-
 drivers/spi/spidev.c            |   17 +++++++++++------
 include/linux/spi/spi.h         |    2 ++
 include/linux/spi/spidev.h      |    2 ++
 4 files changed, 24 insertions(+), 7 deletions(-)

--- a/Documentation/spi/spidev_test.c
+++ b/Documentation/spi/spidev_test.c
@@ -99,11 +99,13 @@ void parse_opts(int argc, char *argv[])
 			{ "lsb",     0, 0, 'L' },
 			{ "cs-high", 0, 0, 'C' },
 			{ "3wire",   0, 0, '3' },
+			{ "no-cs",   0, 0, 'N' },
+			{ "ready",   0, 0, 'R' },
 			{ NULL, 0, 0, 0 },
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:b:lHOLC3", lopts, NULL);
+		c = getopt_long(argc, argv, "D:s:d:b:lHOLC3NR", lopts, NULL);
 
 		if (c == -1)
 			break;
@@ -139,6 +141,12 @@ void parse_opts(int argc, char *argv[])
 		case '3':
 			mode |= SPI_3WIRE;
 			break;
+		case 'N':
+			mode |= SPI_NO_CS;
+			break;
+		case 'R':
+			mode |= SPI_READY;
+			break;
 		default:
 			print_usage(argv[0]);
 			break;
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -58,15 +58,20 @@ static unsigned long	minors[N_SPI_MINORS
 
 
 /* Bit masks for spi_device.mode management.  Note that incorrect
- * settings for CS_HIGH and 3WIRE can cause *lots* of trouble for other
- * devices on a shared bus:  CS_HIGH, because this device will be
- * active when it shouldn't be;  3WIRE, because when active it won't
- * behave as it should.
+ * settings for some settings can cause *lots* of trouble for other
+ * devices on a shared bus:
  *
- * REVISIT should changing those two modes be privileged?
+ *  - CS_HIGH ... this device will be active when it shouldn't be
+ *  - 3WIRE ... when active, it won't behave as it should
+ *  - NO_CS ... there will be no explicit message boundaries; this
+ *	is completely incompatible with the shared bus model
+ *  - READY ... transfers may proceed when they shouldn't.
+ *
+ * REVISIT should changing those flags be privileged?
  */
 #define SPI_MODE_MASK		(SPI_CPHA | SPI_CPOL | SPI_CS_HIGH \
-				| SPI_LSB_FIRST | SPI_3WIRE | SPI_LOOP)
+				| SPI_LSB_FIRST | SPI_3WIRE | SPI_LOOP \
+				| SPI_NO_CS | SPI_READY)
 
 struct spidev_data {
 	dev_t			devt;
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -80,6 +80,8 @@ struct spi_device {
 #define	SPI_LSB_FIRST	0x08			/* per-word bits-on-wire */
 #define	SPI_3WIRE	0x10			/* SI/SO signals shared */
 #define	SPI_LOOP	0x20			/* loopback mode */
+#define	SPI_NO_CS	0x40			/* 1 dev/bus, no chipselect */
+#define	SPI_READY	0x80			/* slave pulls low to pause */
 	u8			bits_per_word;
 	int			irq;
 	void			*controller_state;
--- a/include/linux/spi/spidev.h
+++ b/include/linux/spi/spidev.h
@@ -40,6 +40,8 @@
 #define SPI_LSB_FIRST		0x08
 #define SPI_3WIRE		0x10
 #define SPI_LOOP		0x20
+#define SPI_NO_CS		0x40
+#define SPI_READY		0x80
 
 /*---------------------------------------------------------------------------*/
 

------------------------------------------------------------------------------
