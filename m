From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] powerpc/devicetrees: Change 'gpios' to 'cs-gpios' on
 fsl,spi nodes
Date: Fri, 13 Dec 2019 15:34:18 -0600
Message-ID: <20191213213418.GA17361@bogus>
References: <7556683b57d8ce100855857f03d1cd3d2903d045.1574943062.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org
To: Christophe Leroy <christophe.leroy@c-s.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7556683b57d8ce100855857f03d1cd3d2903d045.1574943062.git.christophe.leroy@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Nov 28, 2019 at 12:16:35PM +0000, Christophe Leroy wrote:
> Since commit 0f0581b24bd0 ("spi: fsl: Convert to use CS GPIO
> descriptors"), the prefered way to define chipselect GPIOs is using
> 'cs-gpios' property instead of the legacy 'gpios' property.

This will break using a new dtb on a kernel without the above commit. Or 
with any OS that never made the change.

I'm fine with the doc change, but you should keep 'gpios' as deprecated.

> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  Documentation/devicetree/bindings/spi/fsl-spi.txt | 8 ++++----
>  arch/powerpc/boot/dts/mgcoge.dts                  | 2 +-
>  arch/powerpc/boot/dts/mpc832x_rdb.dts             | 2 +-
>  arch/powerpc/boot/dts/mpc8610_hpcd.dts            | 2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)
