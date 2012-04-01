From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH/RFC v2] ARM: amba: Remove AMBA level regulator support
Date: Mon, 2 Apr 2012 00:39:11 +0200
Message-ID: <CACRpkda2zh=zR+A9bwhRXYHtQdFeUpiqG4d5g1i82mPCs1mXaQ@mail.gmail.com>
References: <1333306720-28344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<CACRpkdYRStgKo_e-4kZKA-V-OoMiV21jRS3R4g1Cq+4c+4=iQA@mail.gmail.com>
	<CAH+eYFC+q4xFuSdRBkO9nb0XZWU4pQ_yCyinMy2X3ds9WQd1kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CAH+eYFC+q4xFuSdRBkO9nb0XZWU4pQ_yCyinMy2X3ds9WQd1kw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, Apr 1, 2012 at 9:39 PM, Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org> wrote:
> On Mon, Apr 2, 2012 at 00:52, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wr=
ote:
>> Combined with the PL022 patch this causes a power regression since
>> the PL022 is hereafter always on.
>
> How can there be a "power regression" here? =A0This is the only user of
> the vcore regulator, and, apart from the fact that its disable routine
> only decrements an essentialy write-only variable, it is shared which
> several devices which already never disable it.

Yes true... Hm I hope something else in mainline will increase refcount
to vape so it's not disabled at regulator_has_full_constraints()? Better
test it, then I'll see.

Mark: as Rabin says the v1 patch is probably fine, are you pushing this
to ARM SoC or into Russell's patch tracker?

Yours,
Linus Walleij

---------------------------------------------------------------------------=
---
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here =

http://p.sf.net/sfu/sfd2d-msazure
