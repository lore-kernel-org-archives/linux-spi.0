From: Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2 2/5] spi: fspi: dynamically alloc AHB memory
Date: Wed, 12 Feb 2020 07:08:49 -0600
Message-ID: <CAHCN7x+5bACfYVX49Lib+fmNq-dEOkcyi0gXt7rtYxrGaYbH1Q@mail.gmail.com>
References: <20200202125950.1825013-1-aford173@gmail.com> <20200202125950.1825013-2-aford173@gmail.com>
 <CAOMZO5D3emrAk84wDS04qJC-3AyvFnqodhoMsXO-ukHnYsU+PQ@mail.gmail.com>
 <CAHCN7xJyZRwJhnWW2mAbOeGyrMsB7Au_e6AvwiNmNS8gFUfSyw@mail.gmail.com> <20200212120753.GF4028@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Han Xu <han.xu-3arQi8VN3Tc@public.gmane.org>,
        Yogesh Gaur <yogeshgaur.83-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Ashish Kumar <ashish.kumar-3arQi8VN3Tc@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Pengutronix Kernel Team <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200212120753.GF4028-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Feb 12, 2020 at 6:07 AM Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
> On Mon, Feb 03, 2020 at 04:53:34AM -0600, Adam Ford wrote:
>
> > My motivation is to get the flexspi on the i.MX8MM to work, and I did
> > a list of the patches applied on the NXP branch to see what was
> > applied on top of their 4.19 kernel and this patch series generated
> > from that list.  Most of the NXP commits are one-line commits, and I
> > don't know the motivation for what's happening.  NXP did it, and I
> > know it works on the Flexspi driver.
>
> Adding new compatibles and so on seems fine but the patches making
> random changes without explanation like the one for octal mode I just
> replied to are more worrying, do they work with older versions of the IP
> or in all use cases for example?  I'd suggest cutting the initial patch
> series down to the bare minimum needed to get things working and then
> building on top of that if that's not already been done.

The original author was copied on the initial commit.  I literally
generated the patch from NXP's branch,  added my notes, and pushed
them to the mailing lists after testing them on the  the Linux master
branch.   I am a bit disappointed that NXP's author hasn't responded
to any of the comments or feedback.  NXP knows their hardware and
better understands the details as to what is happening and why.  In
any case,  I'll try to scale the patch series back to just enough to
get it working on the i.MX8M Mini.  I'll expand a bit on the commit
message based on what I've learned about the various in-implemented
quirks and send a V2 series.

adam
