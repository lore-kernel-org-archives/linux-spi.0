From: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] fix module autoloading for ACPI enumerated devices
Date: Thu, 16 Jan 2014 21:05:09 +0800
Message-ID: <1389877509.3010.15.camel@rzhang1-mobl4>
References: <1389689198-2641-1-git-send-email-rui.zhang@intel.com>
	 <1389689198-2641-4-git-send-email-rui.zhang@intel.com>
	 <20140116122704.GD2617@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org,
	rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140116122704.GD2617@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, 2014-01-16 at 13:27 +0100, Wolfram Sang wrote:
> > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > index d74c0b3..c4c5588 100644
> > --- a/drivers/i2c/i2c-core.c
> > +++ b/drivers/i2c/i2c-core.c
> > @@ -104,6 +104,11 @@ static int i2c_device_match(struct device *dev, struct device_driver *drv)
> >  static int i2c_device_uevent(struct device *dev, struct kobj_uevent_env *env)
> >  {
> >  	struct i2c_client	*client = to_i2c_client(dev);
> > +	int rc;
> > +
> > +	rc = acpi_device_uevent_modalias(dev, env);
> > +	if (rc != -ENODEV)
> > +		return rc;
> >  
> >  	if (add_uevent_var(env, "MODALIAS=%s%s",
> >  			   I2C_MODULE_PREFIX, client->name))
> 
> I wonder why we don't have/need that with CONFIG_OF? Because probably
> nobody is using modules with i2c devices there?
> 
This seems a gap to me but I'm not 100% sure.
I saw Grant Likely introduced the OF style MODALIAS to platform bus, and
OF style registration/binding to i2c bus, maybe he has an answer for
this.

thanks,
rui
