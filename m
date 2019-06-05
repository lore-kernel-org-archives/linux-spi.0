From: Emil Renner Berthing <kernel@esmil.dk>
Subject: Re: Applied "spi: rockchip: turn down tx dma bursts" to the spi tree
Date: Wed, 5 Jun 2019 21:36:44 +0200
Message-ID: <CANBLGcxiXR7KqKn4U-2PgefuxpBFX=yR06cw6A5GEALuqa54FA@mail.gmail.com>
References: <20190412105320.2924-1-kernel@esmil.dk> <20190508103358.5C7EB440010@finisterre.sirena.org.uk>
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
In-Reply-To: <20190508103358.5C7EB440010@finisterre.sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark

On Wed, 8 May 2019 at 12:34, Mark Brown <broonie@kernel.org> wrote:
>
> The patch
>
>    spi: rockchip: turn down tx dma bursts
>
> has been applied to the spi tree at
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.

I've tried looking in the for-next and for-5.x branches here, and I
can't seem to find this patch.
Am I missing something?

It fixes a problem introduced in 4.19, so it'd be nice if it could
make it to stable trees eventually.

/Emil
