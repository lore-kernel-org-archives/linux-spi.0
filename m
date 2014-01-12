From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH V3 0/5] SoC and board integration for RSPI on r7s72100/genmai
Date: Sun, 12 Jan 2014 22:32:27 +0100
Message-ID: <2996587.8yFdzmUGOy@avalon>
References: <1389523723-2288-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1389523723-2288-1-git-send-email-geert@linux-m68k.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Geert,

Thank you for the patches.

On Sunday 12 January 2014 11:48:38 Geert Uytterhoeven wrote:
> This patch series integrates Renesas RSPI on the RZ/A1H aka R7S72100 SoC,
> and the Genmai development board.
> 
> The series is based on renesas-devel-v3.13-rc7-20140109v2, with Magnus'
> pinctrl, Wolfram's riic, and Simon's sh_eth work applied on top.
> [Simon: I don't know in which order you will merge these. If you want me
>  to rebase my patches, just ask! Thanks!]
> 
> It was tested on the Genmai development board (genmai-reference), using
> an in-kernel version of Documentation/spi/spidev_test.c, exercising
> loopback mode on rspi1, with the same outcome as the SDK reference code.
> 
> It will not yet work with the non-reference version of genmai, due to
> missing pinmux configuration in setup-r7s72100.c.

The whole series looks good to me. The first patch depends on r7s72100 pinmux 
support, for which I'm still waiting a new version from Magnus. The rest could 
already be applied as far as I'm concerned.

>     [1/5] pinctrl: sh-pfc: r7s72100: Add RSPI support
>     [2/5] ARM: shmobile: r7s72100: Add RSPI clocks
>     [3/5] ARM: shmobile: genmai: Add RSPI support
>     [4/5] [RFC] ARM: shmobile: genmai: Add preliminary RSPI pinmux
>     [5/5] ARM: shmobile: genmai: Enable RSPI in defconfig
> 
> Changes in V2:
>   - Add "ARM: shmobile: genmai: Add RSPI children"
>   - Add "[RFC] ARM: shmobile: genmai: Add preliminary RSPI pinmux"
> 
> Changes in V3:
>   - Implement review comments
>   - Add defconfig update
>   - Remove DT support patches, they will be sent in a separate series
>   - Merge "ARM: shmobile: r7s72100: Add RSPI platform devices" and
>     "ARM: shmobile: genmai: Add RSPI children"

-- 
Regards,

Laurent Pinchart

