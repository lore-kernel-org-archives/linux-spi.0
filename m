From: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] spi: Fix handling of cs_change in core implementation
Date: Mon, 31 Mar 2014 09:45:29 +0200
Message-ID: <20140331074529.GE2775@book.gsilab.sittig.org>
References: <1396139265-28900-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org,
	Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1396139265-28900-1-git-send-email-broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sun, 2014-03-30 at 00:27 +0000, Mark Brown wrote:
> 
> From: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> The core implementation of cs_change didn't follow the documentation
> which says that cs_change in the middle of the transfer means to briefly
> deassert chip select, instead it followed buggy drivers which change the
> polarity of chip select.  Use a delay of 10us between deassert and
> reassert simply from pulling numbers out of a hat.
> 
> Reported-by: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
> Signed-off-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

The change looks good to me.  The resulting behaviour now is what
the documentation suggests (brief deassertion of the CS signal).
The previous inversion was unexpected.

The delay between deassertion and re-assertion looks good, too.
It allows for propagation of the change through the hardware.
Those who need longer pauses still can construct individual
messages.  There's probably no need to change the boolean
"cs_change" into a numerical "deassertion pause length" spec.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office-ynQEQJNshbs@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
