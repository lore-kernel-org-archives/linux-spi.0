From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH v2 3/3] drivers core: allow id match override when
 manually binding driver
Date: Mon, 27 Jun 2016 12:09:49 -0700
Message-ID: <20160627190949.GB5111@kroah.com>
References: <cover.1467053363.git.hramrach@gmail.com>
 <15ff382f699387e2d8f23779db851d0de7e9291e.1467053363.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <15ff382f699387e2d8f23779db851d0de7e9291e.1467053363.git.hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Jun 27, 2016 at 09:02:32PM +0200, Michal Suchanek wrote:
> The spi bus has no autodetection whatsoever. The 'detection' of the
> device that's suposed to be on the other side completely relies on user
> supplied information coming from devicetree on many platforms. It is
> completely reasonable then to allow the user to supply the information
> at runtime by doing echo 'somedevice' >
> /sys/bus/spi/drivers/somedriver/bind
> This fails if somedriver does not have in its id table compatible of
> somedevice so just skip this check for manual driver binding.

That's what the new_id file is for, right?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
