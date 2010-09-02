From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: add a bits_per_word to struct spi_board_info
Date: Thu, 2 Sep 2010 10:01:28 +0800
Message-ID: <20100902100128.5d5b7d87@feng-i7>
References: <20100901151010.GB13421@angua.secretlab.ca>
	<220308.75070.qm@web180310.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <220308.75070.qm-4JhmkcZgSkk/JfqJOfUXs/u2YVrzzGjVVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, 1 Sep 2010 23:46:18 +0800
David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:

> Re $SUBJECT ... consider it a quirk of how
> SPI devices get setup that this field isn't
> one of the ones the platform code can set up.
> =

> I've thought about fixing this before,
> and decided against it:
> =

> =

> > What is the use case that you would want to do
>  > this. Knowing what the bits_per_word should
> > be is the responsibility of the spi device
> > driver.=A0 What is the > use-case where the
> > driver wouldn't know what bits_per_word
> > should be?
> =

> What's the case where platform code could
> know "better" than the driver?

Grant also asked me the same question. Yes, driver itself
know the bits_per_word info best in most case, but there is
some device (Option GTM501L spi modem) which supports multiple
bits_per_mode option, and here platform code is the good place
to set it.

One of my intension of this patch is to save some extra spi_setup.
For many spi protocol drivers in kernel, spi_setup() will be
called twice for them, first time is inside spi_new_device(it calls
spi_add_device), the second time will be inside driver's probe
func, after setting bits_per_word info. So if we can set it before
registering board info, then the second spi_setup can be removed for
many drivers.

Thanks,
Feng



---------------------------------------------------------------------------=
---
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
