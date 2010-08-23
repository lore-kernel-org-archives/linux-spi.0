From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v5 1/1] davinci: spi: replace
	existing driver
Date: Sun, 22 Aug 2010 22:40:56 -0600
Message-ID: <062ea2aa-f41b-4320-bbcc-57300da08fb0@email.android.com>
References: <1280355490-11878-1-git-send-email-bniebuhr@efjohnson.com>
	<AANLkTim-FB6YrGSTmDQhmnS+Qw-dGm7D-pH7iCzy0-Td@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E7ED0A13@dbde02.ent.ti.com>
	<201008201406.33473.caglarakyuz@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E8350B45@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org"
	<davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
	Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>,Caglar Akyuz <caglarakyuz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E8350B45-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org



"Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org> wrote:

>Hi Caglar,
>
>On Fri, Aug 20, 2010 at 16:36:33, Caglar Akyuz wrote:
>> On Monday 02 August 2010 06:53:16 pm Nori, Sekhar wrote:
>> > Hi Brian,
>> >
>> > On Mon, Aug 02, 2010 at 19:40:29, Brian Niebuhr wrote:
>> > > Grant -
>> > >
>> > >
>> > >  For my part, I've already sunk way more time into this than I ever
>> > > intended, and I really have no clue how to break this patch down into
>> > > smaller patches.  I don't really care much if the patch gets accepted
>> > > or not - I am just trying to help out all of the other users that are
>> > > stuck with a broken driver like I was.  Maybe if TI wants to give
>> > > their customers a driver that actually works they'll pick it up and do
>> > > the rest of the work that's necessary to get it accepted.
>> >
>> > Thanks for all the work on this so far. We will work on breaking
>> > this patch up and getting the fixes accepted upstream.
>> >
>>
>> Is there any improvement on this or anybody is actively working on submitting
>> patches?
>>
>> I'm going to try this driver on DaVinci DM6446 and OMAP L-138 with different
>> peripherals. If nobody is expected to submit something soon, then I can work
>> on preparing incremental patches while working with the driver. I can start
>> sending patches next week or so.
>
>I have been spending time on this (admittedly on and off) since I wrote that
>email and have broken down the work into ~20 patches so far. Starting to
>scratch the DMA related changes right now. So, I guess I am somewhere midway.
>
>I pushed a branch containing the work so far here:
>
>http://arago-project.org/git/projects/?p=linux-davinci.git;a=shortlog;h=refs/heads/davinci-spi-rewrite

I like what I see so far.  Feel free to post subsets of the whole series as soon as you feel they are ready so I can start adding bits to my next-door branch.

g.
-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
