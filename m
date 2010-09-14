From: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v5 1/1] davinci: spi: replace existing driver
Date: Tue, 14 Sep 2010 11:13:41 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301F6DF4C95@dbde02.ent.ti.com>
References: <1280355490-11878-1-git-send-email-bniebuhr@efjohnson.com>
	<201008201406.33473.caglarakyuz@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E8350B45@dbde02.ent.ti.com>
	<201008231154.10411.caglarakyuz@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E8350E47@dbde02.ent.ti.com>
	<4C8EB795.1080607@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
To: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <4C8EB795.1080607-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
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

On Tue, Sep 14, 2010 at 05:15:25, Michael Williamson wrote:
> Hi Sekhar,
>
> On 08/23/2010 05:30 AM, Nori, Sekhar wrote:
> > On Mon, Aug 23, 2010 at 14:24:10, Caglar Akyuz wrote:
> >> On Monday 23 August 2010 07:28:48 am Nori, Sekhar wrote:
> >>> Hi Caglar,
> >>>
> >>
> >> Hi,
> >>
> >> [...]
> >>
> >>> I have been spending time on this (admittedly on and off) since I wrote
> >>>  that email and have broken down the work into ~20 patches so far. Starting
> >>>  to scratch the DMA related changes right now. So, I guess I am somewhere
> >>>  midway.
> >>>
> >>> I pushed a branch containing the work so far here:
> >>>
> >>> http://arago-project.org/git/projects/?p=linux-davinci.git;a=shortlog;h=ref
> >>> s/heads/davinci-spi-rewrite
> >>>
> >>
>
> I've been trying to take a peek, but the arago site seems to be flakey lately,
> giving a lot of messages like the one below.  Not sure if you are aware of this.

Hmm, I have seen this kind of error in the past, but not lately. Accessed the site
just now without issues.

> Looking forward to seeing this...  Thanks!

Got side-tracked the last two weeks. The DMA changes are the major
chunk left. Hopefully will have the final patch set ready with
little more effort.

Thanks,
Sekhar
