From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: SPI Slave Mode
Date: Tue, 18 Oct 2011 08:04:31 -0600
Message-ID: <CACxGe6uJ-nBXXqeFskE5yQ+4GUUNexOpgd5JcNe6BiSkgt63RQ@mail.gmail.com>
References: <A542D8ED20514C4E88DE6D8CF343C2D901227C40@uksrpblkexb01.detica.com>
	<4E9D6CAE.6080001@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "Holdsworth, Joel" <Joel.Holdsworth-IHqVjY1oUdQYQ022hMJolFaTQe2KTcn/@public.gmane.org>, "Beaumont,
	Charlie \(UK Gloucester\)" <Charlie.Beaumont-IHqVjY1oUdQYQ022hMJolFaTQe2KTcn/@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4E9D6CAE.6080001-/d+BM93fTQY@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Oct 18, 2011 at 6:10 AM, Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org> wrote:
> On 10/18/2011 06:13 AM, Holdsworth, Joel wrote:
>> Hi All,
>>
>> My team are working on an embedded system where we need our application
>> processor to be an SPI slave. The documentation that I have read is very
>> clear that this is currently not supported. I am trying to find out if
>> there is any work planned or underway to add support for this feature,
>> or what work would be required to add support. Would this be the simple
>> addition of a small family of infrastructure functions? Or a major
>> overhaul of the subsystem?
>
> Or is it even possible? =A0It depends on what you want to accomplish.
>
>> Does anyone have any information about these things?
>
> There was considerable discussion of this several years ago.
> I don't think anything has changed since then.
>
> http://www.mail-archive.com/spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org/msg00=
306.html
>
> The short answer is that generalized slave operation requires nearly-inst=
ant
> response from the slave, something that an OS is in capable of. =A0Howeve=
r,
> it can work in specialized circumstances, such as when it is possible to =
always
> predict the next request from the master. =A0Data streaming with a single=
 master
> and slave is such an example.

Yes, pretty much.  It isn't so much that Linux is incapable of doing
it, but it really is an entirely different model from the spi master
infrastructure in the kernel.  I have no problem sharing SPI master
data structures and code between a theoretical SPI slave subsystem,
but the model is sufficiently different that I haven't seen any
approach where it makes sense to try and make the spi master subsystem
handle spi slave operations.

USB is very much in the same vein.  While USB host and USB gadget do
share a bit of code, they are essentially separate subsystems.

g.

---------------------------------------------------------------------------=
---
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2d-oct
