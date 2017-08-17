From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: Re: linux-next: manual merge of the spi tree with the pm tree
Date: Thu, 17 Aug 2017 09:21:42 +0200
Message-ID: <20170817072142.GA11056@wunner.de>
References: <20170817132308.090d4b88@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suniel Mahesh <sunil.m-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>,
        Karthik Tummala <karthik-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170817132308.090d4b88-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Sunil, Hi Karthik,

On Thu, Aug 17, 2017 at 01:23:08PM +1000, Stephen Rothwell wrote:
>   9b61e302210e ("spi: Pick spi bus number from Linux idr or spi alias")

This commit contains numerous trailing whitespace and space as indentation
issues.  Please be sure to run your patches through scripts/checkpatch.pl
before submission to avoid this.

Thanks,

Lukas
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
