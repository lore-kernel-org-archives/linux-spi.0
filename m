From: "hartleys" <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: mmc_spi.c driver
Date: Thu, 30 Oct 2008 18:46:54 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909C28EE4@mi8nycmail19.Mi8.com>
References: <1CF6EDDF0820924DA43C9A52FE7325950A27D544@MI8NYCMAIL17.Mi8.com><200804151137.00997.david-b@pacbell.net><1CF6EDDF0820924DA43C9A52FE7325950A89D882@MI8NYCMAIL17.Mi8.com><200804151204.19776.david-b@pacbell.net><1CF6EDDF0820924DA43C9A52FE7325950A89DA47@MI8NYCMAIL17.Mi8.com><20080424140541.773f6e6b@mjolnir.drzeus.cx><1CF6EDDF0820924DA43C9A52FE7325950ADABC65@MI8NYCMAIL17.Mi8.com><20080507203753.44d18d4f@mjolnir.drzeus.cx><1CF6EDDF0820924DA43C9A52FE7325950B4DAA8C@MI8NYCMAIL17.Mi8.com>
	<20080509212858.7220f665@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Pierre Ossman" <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>,
	"David Brownell" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <20080509212858.7220f665-OhHrUh4vRMSnewYJFaQfwJ5kstrrjoWp@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello Pierre and David,

With the help you supplied to me back in Apr/May I was able to get my
spi driver for the ep93xx cleaned up enough to get the mmc_spi driver to
work correctly. Thanks for the help.

Now I have run into another problem. But I don't know if it's a mdev
issue or something in the mmc core.

When I first boot my system, with the mmc card installed, the card is
detected and the device nodes are created correctly. At that point I can
mount the card and everything works great.

>From boot messages:
...
mmc0: new SD card on SPI
mmcblk0: mmc0:0000 SR016 14400KiB
 mmcblk0: p1
...

# ls /dev/mmc* -la
brw-rw----    1 root     disk     179,   0 Oct 30 09:10 /dev/mmcblk0
brw-rw----    1 root     disk     179,   1 Oct 30 09:10 /dev/mmcblk0p1

Then, if I eject the card I get:

mmc0: SPI card removed

# ls /dev/mmc* -la

And then re-insert it:

mmc0: new SD card on SPI
mmcblk1: mmc0:0000 SR016 14400KiB
mmcblk1: p1

# ls /dev/mmc* -la
crw-rw----    1 root     disk     179,   8 Oct 30 09:30 /dev/mmcblk1
crw-rw----    1 root     disk     179,   9 Oct 30 09:30 /dev/mmcblk1p1

Why does the re-inserted card show up as mmcblk1* instead of mmcblk0*?
Also, why would it change from a block device to a char device and the
minor number has changed?

Thanks for any help you can provide.
Hartley

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
