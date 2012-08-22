From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] spi: Master driver for NXP SC18IS602/603
Date: Wed, 22 Aug 2012 12:19:59 -0700
Message-ID: <20120822191959.GA12403@roeck-us.net>
References: <1345305987-1954-1-git-send-email-linux@roeck-us.net>
 <20120822183230.GC7995@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spi-devel-general@lists.sourceforge.net,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Rob Landley <rob@landley.net>, linux-doc@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120822183230.GC7995@opensource.wolfsonmicro.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Aug 22, 2012 at 07:32:30PM +0100, Mark Brown wrote:
> On Sat, Aug 18, 2012 at 09:06:27AM -0700, Guenter Roeck wrote:
> > This driver adds support for NXP SC18IS602/603 I2C to SPI bus bridge.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Applied, thanks.  One small thing:
> 
> > +static int sc18is602_probe(struct i2c_client *client,
> > +			   const struct i2c_device_id *id)
> > +{
> > +	struct device *dev = &client->dev;
> > +	struct device_node *np = dev->of_node;
> > +	struct sc18is602_platform_data *pdata = dev_get_platdata(dev);
> > +	struct sc18is602 *hw;
> > +	struct spi_master *master;
> > +	int error;
> > +
> > +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
> > +				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA))
> > +		return -ENODEV;
> 
> This feels like the wrong thing to do here: given that the user needs to
> explicitly ask for the device to be instantiated we really ought to be
> one the right bus so this should be more of an error.  Not sure what I
> can constructively sugget except for an error message and perhaps
> returning -EINVAL though.

Hi Mark,

Makes sense. Changing the return value to -EINVAL results in the following
warning message from the driver subsystem.

sc18is602: probe of 7-0010 failed with error -22

I think this should be good enough, as there are other possible reasons for the
call to fail which result in similar messages. Do you want to make that change,
or should I change it and resubmit ?

Thanks,
Guenter
