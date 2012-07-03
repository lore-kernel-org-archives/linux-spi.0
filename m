From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: Re: [PATCH v2 07/12] I2C: MV64XXX: Add Device Tree support
Date: Tue, 3 Jul 2012 18:58:39 +0200
Message-ID: <20120703165839.GA1519@lunn.ch>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <1341325365-21393-8-git-send-email-andrew@lunn.ch>
 <2232439.93KkEvHiYj@flexo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
 devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
 linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
 linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2232439.93KkEvHiYj@flexo>
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

On Tue, Jul 03, 2012 at 05:59:13PM +0200, Florian Fainelli wrote:
> Hello Andrew,
> 
> On Tuesday 03 July 2012 16:22:40 Andrew Lunn wrote:
> > Extends the driver to get properties from device tree. Also extend the
> > kirkwood DT support to supply the needed properties.
> > 
> > Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
> > ---
> [snip]
> > -	if ((pd->id != 0) || !pdata)
> > +	if ((!pdata && !pd->dev.of_node) || (pdata && (pd->id != 0)))
> >  		return -ENODEV;
> 
> This is more a reminder than a real remark, but the driver here should not be 
> limiting us to a single platform_device. In fact kirkwood55 (88F6282) has two 
> I2C controllers for instance.

Yes, i don't understand this code. It looks impossible to use it using
platform_data with more than one controller. Any idea why its like
this? I didn't want to change the behavior because i don't understand
why its like this.

However, it should be possible to instantiate multiple I2C controllers
using DT. However, i've only tested it with one.

      Andrew
