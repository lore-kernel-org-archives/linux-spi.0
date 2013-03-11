From: "Manjunathappa, Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v2 1/4] spi/davinci: add DT binding documentation
Date: Mon, 11 Mar 2013 08:53:30 +0000
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3EA48A6D@DBDE01.ent.ti.com>
References: <1362401955-9616-1-git-send-email-prakash.pm@ti.com>
	<6918845.dALXSKksQd@wuerfel>
	<A73F36158E33644199EB82C5EC81C7BC3EA4854E@DBDE01.ent.ti.com>
	<201303051932.41327.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org"
	<davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
        "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org"
	<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
        "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org"
	<linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org"
	<devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>,
        "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org"
	<rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
        "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org"
	<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        "rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org" <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>,
        "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        "hs-ynQEQJNshbs@public.gmane.org" <hs-ynQEQJNshbs@public.gmane.org>,
        "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <201303051932.41327.arnd-r2nGTMty4D4@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Mar 06, 2013 at 01:02:41, Arnd Bergmann wrote:
> On Tuesday 05 March 2013, Manjunathappa, Prakash wrote:
> > On Mon, Mar 04, 2013 at 21:59:16, Arnd Bergmann wrote:
> > > On Monday 04 March 2013 18:29:12 Manjunathappa, Prakash wrote:
> > > > +- reg: Offset and length of SPI controller register space
> > > > +- num-cs: Number of chip selects
> > > > +- ti,davinci-spi-intr-line: interrupt line used to connect the SPI
> > > > +	IP to the interrupt controller withn the SoC. Possible values
> > > > +	are 0 and 1. Manual says one of the two possible interrupt
> > > > +	lines can be tied to the interrupt controller. Set this
> > > > +	based on a specifc SoC configuration.
> > > > +- interrupts: interrupt number offset at the irq parent
> > > 
> > > I would not call this an "offset". It is an interrupt descriptor
> > > which may be something other than a simple number.
> > > 
> > 
> > I am planning to drop from this documentation as it is common property.
> 
> I think it makese sense to document the fact that there should be exactly
> one interrupt listed in the interrupts property, especially since the
> hardware has two outputs.
> 

Agreed, will consider this property for documenting.

Thanks,
Prakash
