From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] SPI: add support for the PL023
	derivate
Date: Wed, 19 May 2010 14:37:19 -0600
Message-ID: <AANLkTikhY9ooI-K5-apCygxSo8ejMUVjxh9FqmK2YhCD@mail.gmail.com>
References: <1273221653-15654-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: lukasz.baj-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org, marcin.mielczarczyk-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org,
	STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>
To: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1273221653-15654-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, May 7, 2010 at 2:40 AM, Linus Walleij
<linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org> wrote:
> This adds support for a further ST variant of the PL022 called
> PL023. Some differences in the control registers due to being
> stripped down to SPI mode only, and a new clock feedback sample
> delay config setting is available.
>
> Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> ---
> Note: Grant this one is supposed to be applied on top of the
> previous patch to fix up PL022 confusion, I can resend
> these as a condensed patch series if you like, just tell me.
>
> The stuff to be queued in Dan Williams tree for DMA support has
> been tested to be applied before and after this patch and apply
> cleanly so we don't have to worry about these patch sets
> colliding.

This one and the previous patch look okay to me.  I'll pick them up
(assuming no compile breakage).

g.

------------------------------------------------------------------------------
