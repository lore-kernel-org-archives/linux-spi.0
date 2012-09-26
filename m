From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: ABMA: Disable/Enable interface clock from
	suspend/resume
Date: Wed, 26 Sep 2012 14:38:15 +0200
Message-ID: <CACRpkdY_reBeOpyzxdjh9hsc1n_Ff7p5KFBA0Ysys_zDv3WtrA@mail.gmail.com>
References: <1348658647-25975-1-git-send-email-vipulkumar.samar@st.com>
	<1348658647-25975-3-git-send-email-vipulkumar.samar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Vipul Kumar Samar <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>,
	Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Magnus Damm <damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1348658647-25975-3-git-send-email-vipulkumar.samar-qxv4g6HH51o@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Sep 26, 2012 at 1:24 PM, Vipul Kumar Samar
<vipulkumar.samar-qxv4g6HH51o@public.gmane.org> wrote:

> AMBA devices interface clock is disabled in RTPM suspend/resume hooks
> but not in conventional hooks.
>
> This patch adds support to disable/enable clock for conventional
> suspend/resume calls.
(...)
> +       struct amba_device *pcdev = to_amba_device(dev);
>         int ret = 0;
>
>         if (!drv)
> @@ -132,16 +133,27 @@ static int amba_pm_suspend(struct device *dev)
>                 ret = amba_legacy_suspend(dev, PMSG_SUSPEND);
>         }
>
> +       if (!ret)
> +               clk_disable(pcdev->pclk);
> +
>         return ret;
>  }

You're not accounting for the case where pcdev->pclk
is an error pointer (as happens if pclk lookup fails at
probe).

I think you can simplify some of the code using
the external accessors from <linux/amba/bus.h>:

amba_pclk_enable();
amba_pclk_disable();

But:

Again this is a case where you have a race between runtime
suspend/resume and ordinary suspend/resume.

These ordinary suspend/resume operations should probably
wait for runtime suspend to happen *first* if and only if
runtime PM is enabled, and then the block will be gated
off. So we really need to figure out how we can make sure
that this happens.

If just ordinary PM is enabled, the above makes sense but in
that case I think we should have that #ifdef:ed as an alternative
or something.

So something like:

suspend():
#ifdef CONFIG_PM_RUNTIME
   /* Wait for runtime PM to hammer down the pclk */
#elif CONFIG_PM
   amba_pclk_disable();
#endif

resume():
#if defined(CONFIG_PM) && !defined(CONFIG_PM_RUNTIME)
  amba_pclk_enable();
#endif
  /* Let runtime PM lazily enable the clock when needed */

To complicate things further the bus operations can be
overridden by e.g. voltage domains. In this case we (ux500)
have choosen to call out to the AMBA level to make sure
semantics are preserved.

Yours,
Linus Walleij

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
