From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi:pl022: Disable/Enable functional clock from
	suspend/resume
Date: Wed, 26 Sep 2012 14:17:36 +0200
Message-ID: <CACRpkdampxUw0=NO6cs679C-r0_AnPEaTYVc+GppRkKGn32p-w@mail.gmail.com>
References: <1348658647-25975-1-git-send-email-vipulkumar.samar@st.com>
	<1348658647-25975-2-git-send-email-vipulkumar.samar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org,
	spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Vipul Kumar Samar <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>,
	"Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>,
	Magnus Damm <damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1348658647-25975-2-git-send-email-vipulkumar.samar-qxv4g6HH51o@public.gmane.org>
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

> SPI functional clock must be disalble/enable in non RTPM suspend/resume
> hooks. Currently it is only done for RTPM cases.
>
> This patch add support to disable/enbale clock for conventional
> suspend/resume calls.
>
> Signed-off-by: Vipul Kumar Samar <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>

Cross dependency between runtime suspend/resume and
common suspend/resume. Oh the horror ...

Ulf Hansson has experienced pain with this as well, let's
discuss this a bit.

> @@ -2310,6 +2310,8 @@ static int pl022_suspend(struct device *dev)
>         }
>
>         dev_dbg(dev, "suspended\n");
> +       clk_disable(pl022->clk);
> +
>         return 0;
>  }
>
> @@ -2318,6 +2320,12 @@ static int pl022_resume(struct device *dev)
>         struct pl022 *pl022 = dev_get_drvdata(dev);
>         int ret;
>
> +       ret = clk_enable(pl022->clk);
> +       if (ret) {
> +               dev_err(dev, "could not enable SSP/SPI bus clock\n");
> +               return ret;
> +       }
> +

There is a potential race between the runtime
suspend/resume and ordinary suspend/resume hooks here
I'm afraid.

I think in this case since we're not reading nor writing
registers, we should just wait for the device to
go down to runtime suspend in the ordinary suspend
hook, just wait for runtime suspend to happen in
suspend, do nothing in resume (and wait for the device
to wake itself as needed).

So something like:

while (!pm_runtime_status_suspended(&dev))
   cpu_relax();  // or usleep_range()?
/* Here you know the block is gated off */

Or is this better:

pm_runtime_get_sync();
/* Now we know for sure it's on! */
pm_runtime_put_sync();
/* Now we know for sure it's off! */

Is there a *good* way to await runtime suspend?

I don't know if any of this is the proper solution so let
Rafael and Magnus comment on how it's supposed
to be done.


Ramblings:

The semantics between runtime suspend/resume and
ordinary suspend/resume are unclear to me, it seems like
this is all up to the drivers and busses to figure out. Like
you weren't supposed to use both at the same time.

What we've done in other drivers here at ST-Ericsson is
to make the .suspend hook actually do a runtime get so that
runtime PM is "running", then hammer off all resources
and go to suspend with PM runtime actually enabled.

Something like this:

suspend()
  pm_runtime_get_sync()
  /* Maybe poke some registers here */
  clk_disable();

resume():
  clk_enable();
  /* Maybe poke some registers here */
  pm_runtime_put();

This is to be sure that there is not a race between runtime
suspend/resume and ordinary suspend/resume.

I don't like it since it actually turns things upside-down
completely, during ordinary suspend the device is
"runtime resumed" for example.

Rafael, Magnus: help.

Yours,
Linus Walleij

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
