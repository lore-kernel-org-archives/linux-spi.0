From: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v8 01/11] mfd: add driver for sequencer serial port
Date: Thu, 17 Mar 2011 13:03:12 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C307FE5@dbde02.ent.ti.com>
References: <1295378505-15221-1-git-send-email-cyril@ti.com>
	<1295378505-15221-2-git-send-email-cyril@ti.com>	<87tyh4u6uo.fsf@ti.com>
	<20110131004001.GF2565@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
        "dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org" <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>,
        "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
        "linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org" <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
To: "Chemparathy, Cyril" <cyril-l0cyMroinI0@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20110131004001.GF2565@sortiz-mobl>
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

Hi Cyril,

On Mon, Jan 31, 2011 at 06:10:02, Samuel Ortiz wrote:
> Hi Kevin,
> 
> On Wed, Jan 19, 2011 at 09:43:43AM -0800, Kevin Hilman wrote:
> > Samuel,
> > 
> > Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org> writes:
> > 
> > > TI's sequencer serial port (TI-SSP) is a jack-of-all-trades type of serial port
> > > device.  It has a built-in programmable execution engine that can be programmed
> > > to operate as almost any serial bus (I2C, SPI, EasyScale, and others).
> > >
> > > This patch adds a driver for this controller device.  The driver does not
> > > expose a user-land interface.  Protocol drivers built on top of this layer are
> > > expected to remain in-kernel.
> > >
> > > Signed-off-by: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
> > 
> > Any comments on this driver?
> The driver looks fine.
> 
> 
> > With your ack, I'll be happy to merge this via the davinci tree with the
> > rest of the series.
> Please go ahead and add my Acked-by: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Patches in this series which have been Acked by respective maintainers
have been included in the 2.6.39 pull request Kevin sent to Russell.

Once 2.6.39-rc1 is out, can you please plan to rebase and repost the
left out patches and ask the respective maintainers for their review and
ack?

Thanks,
Sekhar
