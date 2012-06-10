From: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Subject: Re: [PATCH 9/9] Kirkwood: Add basic device tree support for QNAP
 TS219.
Date: Sun, 10 Jun 2012 23:22:01 +0200
Message-ID: <201206102322.01981.michael@walle.cc>
References: <1339324322-29388-10-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
 linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
 linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1339324322-29388-10-git-send-email-andrew-g2DYL2Zd6BY@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-spi.vger.kernel.org

Am Sonntag 10 Juni 2012, 12:32:01 schrieb Andrew Lunn:

[..]

> +config MACH_TS219_DT
> +	bool "Device Tree for QNAP TS-110, TS-119, TS-119P+, TS-210, TS-219,
> TS-219P and TS-219P+ Turbo NAS" +	select ARCH_KIRKWOOD_DT
> +	select ARM_APPENDED_DTB
> +	select ARM_ATAG_DTB_COMPAT
> +	help
> +	  Say 'Y' here if you want your kernel to support the QNAP
> +  	  TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and
> +  	  TS-219P+ Turbo NAS devices using Fattened Device Tree.
> +  	  There are two different Device Tree descriptions, depending
> +  	  on if the device is based on an if the board uses the MV6281
> +  	  or MV6282. If you have the wrong one, the buttons will not
> +  	  work.
> +

whitespace errors above


-- 
Michael
