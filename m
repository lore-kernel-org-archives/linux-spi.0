From: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH v2 07/12] I2C: MV64XXX: Add Device Tree support
Date: Wed, 04 Jul 2012 21:49:33 +0200
Message-ID: <1779200.JgQeyzoLkl@bender>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
	<2232439.93KkEvHiYj@flexo> <20120703165839.GA1519@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120703165839.GA1519-g2DYL2Zd6BY@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello Andrew,

On Tuesday 03 July 2012 18:58:39 Andrew Lunn wrote:
> On Tue, Jul 03, 2012 at 05:59:13PM +0200, Florian Fainelli wrote:
> > Hello Andrew,
> > 
> > On Tuesday 03 July 2012 16:22:40 Andrew Lunn wrote:
> > > Extends the driver to get properties from device tree. Also extend the
> > > kirkwood DT support to supply the needed properties.
> > > 
> > > Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
> > > ---
> > [snip]
> > > -	if ((pd->id != 0) || !pdata)
> > > +	if ((!pdata && !pd->dev.of_node) || (pdata && (pd->id != 0)))
> > >  		return -ENODEV;
> > 
> > This is more a reminder than a real remark, but the driver here should not 
be 
> > limiting us to a single platform_device. In fact kirkwood55 (88F6282) has 
two 
> > I2C controllers for instance.
> 
> Yes, i don't understand this code. It looks impossible to use it using
> platform_data with more than one controller. Any idea why its like
> this? I didn't want to change the behavior because i don't understand
> why its like this.

No idea, we just stumbled over this with a colleague the other day, and just 
removing the check made our second I2C controller work, so I don't see any 
reason why there is such a limitation. That said, this is for a subsequent 
patch.

> 
> However, it should be possible to instantiate multiple I2C controllers
> using DT. However, i've only tested it with one.
> 
>       Andrew
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-- 
Florian

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
