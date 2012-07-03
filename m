From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: Re: [PATCH v2 11/12] ARM: Kirkwood: Use DT to configure SATA device.
Date: Tue, 3 Jul 2012 17:32:40 +0200
Message-ID: <20120703153240.GH17534@lunn.ch>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <1341325365-21393-12-git-send-email-andrew@lunn.ch>
 <CAMW5Ufa2bsYs9VD2g9hJWKpcQNcZt+WXCA1ohYoHeLk9SambSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
 devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
 linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
 linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Josh Coombs <josh.coombs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMW5Ufa2bsYs9VD2g9hJWKpcQNcZt+WXCA1ohYoHeLk9SambSg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Tue, Jul 03, 2012 at 10:52:17AM -0400, Josh Coombs wrote:
> On Tue, Jul 3, 2012 at 10:22 AM, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org> wrote:
> > Convert boards using DT, but the old way of configuring SATA to now
> > use properties in there DT file.
> 
> Andrew, should I be updating my GoFlex patch set to work with these
> new Kirkwood DT abstractions, and if so is there a specific tree you'd
> prefer I work against, or should I wait to see if my existing patch
> set is approved as is and update with a new patch once these updates
> land in an RC?

Hi Josh

I would suggest waiting for a day or two. The IRQ and GPIO patch may
cause comments and require more work. Unfortunately, without that
patch, the rest are pretty useless, since they use IRQs in DT.

If there are no show stoppers, Jason has a for-next tree which these
patches should get pulled into, and others can use as a basis.

	Andrew
