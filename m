From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH V5 3/3] spi: spi-geni-qcom: Add SPI driver support for
 GENI based QUP
Date: Tue, 9 Oct 2018 10:48:55 -0700
Message-ID: <CAD=FV=U-ZZQhFKR9kxYnw=F1j+dExrsgFvjabYJ8AVmBDM4eXA@mail.gmail.com>
References: <1538574265-30235-1-git-send-email-alokc@codeaurora.org>
 <1538574265-30235-4-git-send-email-alokc@codeaurora.org> <153904219713.119890.7463642233895152532@swboyd.mtv.corp.google.com>
 <CAD=FV=XnYucy4JmgATrB89RYHTbzRC_GaouaRjHAocD4-H0ncg@mail.gmail.com> <153910152600.119890.14820584405992384926@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: alokc@codeaurora.org, Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>
To: Stephen Boyd <swboyd@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <153910152600.119890.14820584405992384926@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Tue, Oct 9, 2018 at 9:12 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Doug Anderson (2018-10-08 16:52:36)
> > Hi,
> >
> > On Mon, Oct 8, 2018 at 4:43 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > > +       mas->irq = platform_get_irq(pdev, 0);
> > > > +       if (mas->irq < 0) {
> > > > +               ret = mas->irq;
> > > > +               dev_err(&pdev->dev, "Err getting IRQ %d\n", ret);
> > > > +               goto spi_geni_probe_runtime_disable;
> > > > +       }
> > >
> > > Nitpick: If you got the irq earlier before allocating anything then nothing has
> > > to be put on failure path.
> >
> > I think this might have been in response to previous feedback from you
> > suggesting that we should get the irq as late as possible.  Ah, here
> > ya go:
> >
> > https://lkml.kernel.org/r/153780767551.119890.9339380838620508307@swboyd.mtv.corp.google.com
>
> Yes I suggested we register for the irq as last as possible, but I
> didn't suggest calling platform_get_irq() this late. It could be called
> earlier so that if there isn't any irq then nothing to do besides return
> failure.

Ah, you're suggesting separating the platform_get_irq() and the
request_irq() so that we call platform_get_irq() as the first thing in
the function but don't do the request_irq() until later.  Yeah, that
could be done and I guess if you feel strongly about it I wouldn't
object to the change, but I don't feel it buys us a lot and I kind of
like keeping the two next to each other.  Specifically why I don't
think it buys us a lot:

1. You still need the "dev_err" print, right?  platform_get_irq()
doesn't automatically print errors for you I think.

2. You now need a local variable "irq".  By putting the
platform_get_irq() before the memory allocation you now can't store it
directly in mas->irq.  We could try using "ret" as a temporary
variable but that seems worse in this case since it'd be a bit
fragile.

3. You don't get rid of any error labels / error handling so we don't
really save any code

When I tried this my diffstat says 8 lines added and 7 removed, so a
net increase in LOC FWIW.  I'm relying in gmail so my patch will be
whitespace-damaged (sigh), but you can find a clean one at:

https://chromium.googlesource.com/chromiumos/third_party/kernel/+/e0325d618e209c22379e3a4269c14627b19243a8%5E%21/#F0

...the basic idea is this though:

@@ -543,6 +543,13 @@
   struct spi_geni_master *mas;
   struct resource *res;
   struct geni_se *se;
+  int irq;
+
+  irq = platform_get_irq(pdev, 0);
+  if (irq < 0) {
+    dev_err(&pdev->dev, "Err getting IRQ %d\n", irq);
+    return irq;
+  }

   spi = spi_alloc_master(&pdev->dev, sizeof(*mas));
   if (!spi)
@@ -553,6 +560,7 @@
   mas->dev = &pdev->dev;
   mas->se.dev = &pdev->dev;
   mas->se.wrapper = dev_get_drvdata(pdev->dev.parent);
+  mas->irq = irq;
   se = &mas->se;

   spi->bus_num = -1;
@@ -589,13 +597,6 @@
   if (ret)
     goto spi_geni_probe_runtime_disable;

-  mas->irq = platform_get_irq(pdev, 0);
-  if (mas->irq < 0) {
-    ret = mas->irq;
-    dev_err(&pdev->dev, "Err getting IRQ %d\n", ret);
-    goto spi_geni_probe_runtime_disable;
-  }
-
   ret = request_irq(mas->irq, geni_spi_isr,
       IRQF_TRIGGER_HIGH, "spi_geni", spi);
   if (ret)


-Doug
