From: Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>
Subject: Re: [PATCH/RFC] ARM: amba: Remove AMBA level regulator support
Date: Mon, 2 Apr 2012 01:02:36 +0530
Message-ID: <CAH+eYFDqTrgpz7Rh+LyUUMBp+PuURgLzF5xv94jK7HkhDLRoHA@mail.gmail.com>
References: <1333294181-27653-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<CACRpkdb6+2SLm1Ojw2jNkK9ejW66fw2Pcit-b3AL67wP4Hr_ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CACRpkdb6+2SLm1Ojw2jNkK9ejW66fw2Pcit-b3AL67wP4Hr_ow-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, Apr 1, 2012 at 22:52, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrot=
e:
> On Sun, Apr 1, 2012 at 5:29 PM, Mark Brown
> <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
>> The impact should be minimal since currently there are no mainline
>> systems which actually provide a vcore regulator so none need updating.
>
> Oh yes there are:
> drivers/mfd/db8500-prcmu.c
>
> This driver registers a number of voltage domain regulators,
> among those:
>
> static struct regulator_consumer_supply db8500_vape_consumers[] =3D {
> =A0 =A0 =A0 (...)
> =A0 =A0 =A0 =A0REGULATOR_SUPPLY("vcore", "sdi0"),
> =A0 =A0 =A0 =A0REGULATOR_SUPPLY("vcore", "sdi1"),
> =A0 =A0 =A0 =A0REGULATOR_SUPPLY("vcore", "sdi2"),
> =A0 =A0 =A0 =A0REGULATOR_SUPPLY("vcore", "sdi3"),
> =A0 =A0 =A0 =A0REGULATOR_SUPPLY("vcore", "sdi4"),
> =A0 =A0 =A0 =A0(...)
> =A0 =A0 =A0 =A0REGULATOR_SUPPLY("vcore", "uart0"),
> =A0 =A0 =A0 =A0REGULATOR_SUPPLY("vcore", "uart1"),
> =A0 =A0 =A0 =A0REGULATOR_SUPPLY("vcore", "uart2"),
>
> IIRC the machine will not boot (i.e. these drivers cannot even
> probe) without these regulators in place, so they get enabled by
> the AMBA bus code.

These vcore "regulators" do nothing but increment a variable which is
write-only in mainline, so the machine will boot and drivers will probe
fine with Mark's patch.

---------------------------------------------------------------------------=
---
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here =

http://p.sf.net/sfu/sfd2d-msazure
