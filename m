From: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 3/6] mtd: m25p80: add support to
 parse the SPI flash's partitions
Date: Tue, 10 Aug 2010 20:01:57 +0400
Message-ID: <20100810160157.GA24553@oksana.dev.rtsoft.ru>
References: <AANLkTik9cy+at2n28U+Mut4RD6_cJ9uRZzjf+H86d-rp@mail.gmail.com>
	<796604.30863.qm@web180307.mail.gq1.yahoo.com>
	<AANLkTi=FGf9gbWDkO4qs01Z+qkip+Zm11=Jc4wHu3G8b@mail.gmail.com>
	<OF0D24DC16.E1FE65D2-ONC125777B.002E544A-C125777B.002EA7C2@transmode.se>
	<AANLkTinYYTj+dR6ckPoShHKZTUmENEA1O-DYP9mjnWrs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>, kumar.gala-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
	David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	"linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org Mingkai Hu" <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinYYTj+dR6ckPoShHKZTUmENEA1O-DYP9mjnWrs-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Aug 10, 2010 at 08:56:42AM -0600, Grant Likely wrote:
[...] 
> The suggestion has been raised to use something like bus notifiers to
> get a hook onto the device registration before the driver is probed so
> that the platform_data can be translated in an separate chuck of code,
> but down that path lies insanity.  There are all kinds of ordering
> issues (like making sure the translation code is called before the
> driver probe code), and it is a lot of complexity for what is really a
> simple thing.

There's another option: platform data handlers (they could be
chained, in case if we want to use several methods of obtaining
platform data, i.e. "try raw data, then ACPI, then OF").

See include/linux/spi/mmc_spi.h (mmc_spi_get_pdata)
and drivers/mmc/host/of_mmc_spi.c.

I think we might implement some library to make these handlers
more generic, but even the simple implementation as in mmc_spi
case proves that it is possible to separate OF/ACPI/DMI/whatever
handling from the generic code.

-- 
Anton Vorontsov
email: cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
irc://irc.freenode.net/bd2

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
