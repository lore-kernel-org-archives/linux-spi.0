From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv2 1/3] bindings: spi: Add devicetree binding for
 spi-xilinx
Date: Thu, 17 Mar 2016 11:43:21 -0500
Message-ID: <20160317164321.GB8920@rob-hp-laptop>
References: <1457513242-11202-1-git-send-email-shubhraj@xilinx.com>
 <20160310033027.GJ3898@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org,
	Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160310033027.GJ3898-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Mar 10, 2016 at 10:30:27AM +0700, Mark Brown wrote:
> On Wed, Mar 09, 2016 at 02:17:20PM +0530, Shubhrajyoti Datta wrote:
> > Add a binding document for the spi/spi-xilinx
> 
> Please use subject lines matching the style for the subsystem.

You are wanting "spi: ..."? This is bindings though and my preference 
would be "dt-bindings: spi: "... That said, I don't really try to 
enforce anything given bindings currently get merged thru many trees.

Rob
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
