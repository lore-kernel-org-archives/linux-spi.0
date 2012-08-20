From: Roland Stigge <stigge@antcom.de>
Subject: Re: [PATCH RESEND v4] spi/pl022: add devicetree support
Date: Mon, 20 Aug 2012 14:58:12 +0200
Message-ID: <50323464.4070006@antcom.de>
References: <1345462769-17386-1-git-send-email-aletes.xgr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Rob Landley <rob@landley.net>,
	devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1345462769-17386-1-git-send-email-aletes.xgr@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi all,

On 08/20/2012 01:39 PM, Alexandre Pereira da Silva wrote:
> Add the chipselect array and cur_cs properties to pl022 main structure
>
> Add a wrapper function to decide if the cs should be controlled by the
> cs_control callback or the chipselect gpio
>
> Populate chipselect property from cs-gpios
>
> Populate master->dev.of_node, so the spi bus can find child spi
> devices and register them
>
> At pl022 setup, fill chip_data structure from dt nodes, if not provided
> by platform.
>
> Signed-off-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
> Acked-by: Roland Stigge <stigge@antcom.de>

We somehow missed 3.6 with this one. Would be nice to have it in 3.7 now
since it's useful for mach-lpc32xx when it's available.

If there are any open issues, I can assist Alexandre on this patch.

Thanks in advance,

Roland
