From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi: Support dev_pm_ops
Date: Fri, 24 Dec 2010 11:23:09 -0700
Message-ID: <AANLkTim6uhaO8=oWDvufG7yOyyy+UvcGFAqZHX_u2D6x@mail.gmail.com>
References: <1293024339-26589-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20101224085255.GE5544@angua.secretlab.ca>
	<20101224113127.GA15474@opensource.wolfsonmicro.com>
	<201012241428.37152.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <201012241428.37152.rjw-KKrjLPT3xs0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Dec 24, 2010 at 6:28 AM, Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org> wrote:
> On Friday, December 24, 2010, Mark Brown wrote:
>> On Fri, Dec 24, 2010 at 01:52:55AM -0700, Grant Likely wrote:
>> > On Wed, Dec 22, 2010 at 02:28:23PM +0100, Rafael J. Wysocki wrote:
>>
>> > > > Allow SPI drivers to use runtime PM and other dev_pm_ops features by
>> > > > implementing dev_pm_ops for the bus. The existing bus specific suspend
>> > > > and resume functions will be called if a driver does not provide dev_pm_ops
>> > > > allowing for transition to the new model.
>> > > >
>> > > > Signed-off-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
>>
>> > > It looks good to me.
>>
>> > I'll take that as an ack.
>>
>> > picked up for -next, thanks.
>>
>> Note that as mentioned it does depend on the patch prototyping the
>> generic ops so it might be better to merge via the PM tree or wait for
>> things to shake out in the merge window.
>
> I can take this one the the PM tree, but I need an ACK from Grant.

Yeah, it failed on sanity testing on my end.  Dropping from my tree.
Rafael, feel free to take it via the PM tree.

g.

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
