From: Emil Renner Berthing <kernel@esmil.dk>
Subject: Re: Applied "spi: rockchip: turn down tx dma bursts" to the spi tree
Date: Wed, 5 Jun 2019 22:14:59 +0200
Message-ID: <CANBLGcwE_KfwJ=-FKNJ9RzrH58FVcmyxAR9niWQRubjM0pZgWA@mail.gmail.com>
References: <20190412105320.2924-1-kernel@esmil.dk> <20190508103358.5C7EB440010@finisterre.sirena.org.uk>
 <CANBLGcxiXR7KqKn4U-2PgefuxpBFX=yR06cw6A5GEALuqa54FA@mail.gmail.com> <20190605195511.GX2456@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-spi@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Vicente Bergas <vicencb@gmail.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190605195511.GX2456@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 5 Jun 2019 at 21:55, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Jun 05, 2019 at 09:36:44PM +0200, Emil Renner Berthing wrote:
> > On Wed, 8 May 2019 at 12:34, Mark Brown <broonie@kernel.org> wrote:
>
> > >    spi: rockchip: turn down tx dma bursts
>
> > I've tried looking in the for-next and for-5.x branches here, and I
> > can't seem to find this patch.
> > Am I missing something?
>
> > It fixes a problem introduced in 4.19, so it'd be nice if it could
> > make it to stable trees eventually.
>
> 47300728fb213486a830565d2af49da967c9d16a is in my tree.  When it reaches
> Linus' tree send a request to Greg for it to be backported if none of
> the stable automation picks it up.

You're absolutely right, sorry about the noise.

Thanks.
/Emil
