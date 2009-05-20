From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] spi: fix m25p80 when the cs_change
	hint is honored
Date: Tue, 19 May 2009 22:09:19 -0700
Message-ID: <200905192209.19125.david-b@pacbell.net>
References: <1242731340-12160-1-git-send-email-baruch@tkos.co.il>
	<200905192134.14316.david-b@pacbell.net>
	<20090520045506.GD28870@tarshish>
Reply-To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20090520045506.GD28870@tarshish>
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

On Tuesday 19 May 2009, Baruch Siach wrote:
> Thanks for the clarification.
> =

> If I understood correctly then, cs_change has two opposite meanings:

No, it has exactly one meaning -- *change* normal behavior -- but that
gets applied in two different contexts, where "normal" is two things:


> 1. If cs_change !=3D 0 in spi_transfer that is not the last in the curren=
t =

> =A0 =A0spi_message, then deactivate the chip select between this spi_tran=
sfer and =

> =A0 =A0the next.
> =

> 2. If cs_change !=3D 0 in spi_transfer that is that last in the current =

> =A0 =A0spi_message, then the SPI controller is allowed to NOT deactivate =
the chip =

> =A0 =A0select after the current spi_message.
> =

> Is this correct? =


Modulo nuances on #2, yes.  See the kerneldoc for more info.


> If so would a clarification of the relevant text at  =

> include/linux/spi/spi.h be accepted?

In what way is the existing language unclear?  There are
two paragraphs in the "struct spi_transfer" kerneldoc.

 =

> baruch
> =




---------------------------------------------------------------------------=
---
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables =

unlimited royalty-free distribution of the report engine =

for externally facing server and web deployment. =

http://p.sf.net/sfu/businessobjects
