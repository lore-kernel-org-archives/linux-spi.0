From: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: mmc_spi.c driver
Date: Fri, 31 Oct 2008 08:02:54 +0100
Message-ID: <20081031080254.54b22b82@mjolnir.drzeus.cx>
References: <1CF6EDDF0820924DA43C9A52FE7325950A27D544@MI8NYCMAIL17.Mi8.com>
	<200804151137.00997.david-b@pacbell.net>
	<1CF6EDDF0820924DA43C9A52FE7325950A89D882@MI8NYCMAIL17.Mi8.com>
	<200804151204.19776.david-b@pacbell.net>
	<1CF6EDDF0820924DA43C9A52FE7325950A89DA47@MI8NYCMAIL17.Mi8.com>
	<20080424140541.773f6e6b@mjolnir.drzeus.cx>
	<1CF6EDDF0820924DA43C9A52FE7325950ADABC65@MI8NYCMAIL17.Mi8.com>
	<20080507203753.44d18d4f@mjolnir.drzeus.cx>
	<1CF6EDDF0820924DA43C9A52FE7325950B4DAA8C@MI8NYCMAIL17.Mi8.com>
	<20080509212858.7220f665@mjolnir.drzeus.cx>
	<BD79186B4FD85F4B8E60E381CAEE1909C28EE4@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "hartleys" <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE1909C28EE4-KURmP/Qoe8Pmp66j18f85VaTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, 30 Oct 2008 18:46:54 -0400
"hartleys" <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org> wrote:

> 
> Why does the re-inserted card show up as mmcblk1* instead of mmcblk0*?
> Also, why would it change from a block device to a char device and the
> minor number has changed?
> 

I'd guess you forgot to unmount the card. The device name "mmcblk0"
will still be around in that case and it will take the next one in line.

No idea why it pops up as a character device. Must be some mdev bug.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  rdesktop, core developer          http://www.rdesktop.org

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
