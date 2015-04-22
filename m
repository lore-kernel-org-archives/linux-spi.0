From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH v2] spi: fsl-spi: use of_iomap() to map parameter ram on CPM1
Date: Wed, 22 Apr 2015 22:46:05 +0200
Message-ID: <CAOiHx==hwBGsYwT6MFV-ur=wnnUmqw_GF7sN8KOwUho3fz5uew@mail.gmail.com>
References: <20150422141721.D3F8C1A242E@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150422141721.D3F8C1A242E-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Christophe,

On Wed, Apr 22, 2015 at 4:17 PM, Christophe Leroy
<christophe.leroy-GgN8y9CXRhA@public.gmane.org> wrote:
> On CPM2, the SPI parameter RAM is dynamically allocated in the
> dualport RAM whereas in CPM1, it is statically allocated to a default
> address with capability to relocate it somewhere else via the use of
> CPM micropatch. The address of the parameter RAM is given by the boot
> loader and expected to be mapped via of_iomap()
>
> In the current implementation, in function fsl_spi_cpm_get_pram()
> there is a confusion between the SPI_BASE register and the base of the
> SPI parameter RAM. Fortunatly, it is working properly with MPC866 and
> MPC885 because they do set SPI_BASE, but on MPC860 and other old
> MPC8xx that doesn't set SPI_BASE, pram_ofs is not properly set.
> Also, the parameter RAM is not properly mapped with of_iomap() as it
> should but still gets accessible by chance through the full RAM which
> is mapped from somewhere else.
>
> This patch applies to the SPI driver the same principle as for the
> CPM UART: when the CPM is of type CPM1, we simply do an of_iomap() of
> the area provided via the device tree.
>
> Signed-off-by: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
>
> ---
>  v2: Use devm_ioremap_resource() instead of_iomap()

Your subject and commitlog still talk about using of_iomap(), you need
to update them too.


Regards
Jonas
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
