From: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Subject: Re: [PATCH v2 0/4] ARM: mvebu: Add support for SPI flash devices
 in Armada 370/XP
Date: Thu, 14 Feb 2013 14:34:10 -0500
Message-ID: <20130214193410.GL14746@titan.lakedaemon.net>
References: <1360155984-15397-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <511257C6.2070604@free-electrons.com>
 <20130206132850.GC14746@titan.lakedaemon.net>
 <CALF0-+WLh=8QGG4ob8HVq+x4oO_ArdFHd=vH1_OhucH1f9XG3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
 devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
 Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ezequiel Garcia <elezegarcia-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CALF0-+WLh=8QGG4ob8HVq+x4oO_ArdFHd=vH1_OhucH1f9XG3A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Wed, Feb 13, 2013 at 06:24:14AM -0300, Ezequiel Garcia wrote:
> Hi Jason,
> 
> On Wed, Feb 6, 2013 at 10:28 AM, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org> wrote:
> > On Wed, Feb 06, 2013 at 02:16:54PM +0100, Gregory CLEMENT wrote:
> >> On 02/06/2013 02:06 PM, Ezequiel Garcia wrote:
> >> > This is second version of the SPI patchset for Armada 370/XP.
> >> >
> >> > This series first adds support for the SPI controller
> >> > and then adds the SPI flash for the Armada XP GP board.
> >> >
> >> > This series is based on 3.8-rc5 plus:
> >> >  * "arm: mvebu: support for the new Armada XP development board(DB-MV784MP-GP)"
> >> >  * "arm: mvebu: i2c come back in defconfig"
> >> >
> >> > Feel free to test or provide any feedback!
> >> >
> >> Ezequiel,
> >>
> >> I reviewed the patches, I have nothing more to say, I can add my:
> >>
> >> Acked-by: Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> >>
> >> on the patch that didn't have yet.
> >>
> >> Jason,
> >> could you add this series in your incoming pull request?
> >
> > That's the plan.  I'm waiting for a response from Olof to see If I need
> > to redo /boards and /dt.  In either case, my next round of pull requests
> > with have this and a bunch of other stuff.
> >
> 
> Despite we're almost closed for v3.9 new material,
> I hope you don't mind a little ping on the USB and SPI stuff.
> 
> I'd *really* love to see these in v3.9, if at all possible.

Yes, I got called out for a few days and just got back into things
today.  once I've read evreything I'll do what I can.

thx,

Jason.
