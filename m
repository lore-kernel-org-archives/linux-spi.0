From: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v8 03/11] gpio: add ti-ssp gpio driver
Date: Fri, 18 Mar 2011 12:00:04 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C3B8330@dbde02.ent.ti.com>
References: <1295378505-15221-1-git-send-email-cyril@ti.com>
	<1295378505-15221-4-git-send-email-cyril@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024BF35DAF@dbde02.ent.ti.com>
	<20110317184514.GP9597@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
        "dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        "sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org" <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>,
        "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20110317184514.GP9597-MrY2KI0G/OVr83L8+7iqerDks+cytr/Z@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Grant,

On Fri, Mar 18, 2011 at 00:15:14, Grant Likely wrote:
> On Mon, Feb 28, 2011 at 06:04:32PM +0530, Nori, Sekhar wrote:
> > Hi Grant,
> > 
> > On Wed, Jan 19, 2011 at 00:51:37, Chemparathy, Cyril wrote:
> > > TI's SSP controller pins can be directly read and written to behave like a
> > > GPIO.  This patch adds a GPIO driver that exposes such functionality.
> > 
> > Can you please review and ack the GPIO part of this
> > series too?
> > 
> > I see that you have already acked the SPI part of this work.
> 
> Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> 
> Sorry for the delay on this.  I can take it through my tree if you
> like.  It's a new driver, so I don't have any concerns about taking it
> now even though the merge window is already open..

Please queue this for the 2.6.40 cycle. I just noticed that with
the 2.6.39 merge, the mfd portion of this needs a linux/sched.h
include to build successfully. That would be fixed in the 2.6.39-rc cycle.

Thanks,
Sekhar
