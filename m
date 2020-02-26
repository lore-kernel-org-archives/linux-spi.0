From: Chuanhong Guo <gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/2] rewrite mtk-quadspi spi-nor driver with spi-mem
Date: Wed, 26 Feb 2020 09:31:33 +0800
Message-ID: <CAJsYDVKqcd-ytLLf5zKqs8DfjPAa5ELCX53OiPDAi-tDnLd=Eg@mail.gmail.com>
References: <20200215065826.739102-1-gch981213@gmail.com> <20200218125557.GD4232@sirena.org.uk>
 <CAJsYDVL03KJv7eewGekBPCfpbOuTX0tJ6qZaydvJnBDzZ5vEwg@mail.gmail.com> <20200225173137.GA31830@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Miquel Raynal <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>,
        Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>,
        Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200225173137.GA31830@bogus>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi!

On Wed, Feb 26, 2020 at 1:31 AM Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
> On Thu, Feb 20, 2020 at 07:58:06AM +0800, Chuanhong Guo wrote:
> > Hi!
> >
> > On Tue, Feb 18, 2020 at 8:55 PM Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > > This is an ABI break so you shouldn't be doing this, if the existing
> > > binding works it should continue to work.
> >
> > The missing spi-max-frequency is the only part preventing old
> > device tree to work with this driver.
> > If the goal is to make existing dt binding work, I could patch dt using
> > of_add_property in v2. I saw similar device tree patching for legacy
> > bindings in pinctrl-single driver.

I just noticed that of_add_property isn't a exported symbol, which means that
device tree patching isn't possible unless driver is builtin.

>
> You should should really only need 'spi-max-frequency' if the max freq
> is less than the minimum of the host and device max freq.

But current spi framework forces that a "spi-max-frequency" property
is present. [0]
Should we patch spi framework then?

[0] https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi.c#L1951
-- 
Regards,
Chuanhong Guo
