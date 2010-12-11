From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 00/49] spi: davinci: re-write existing driver
Date: Sat, 11 Dec 2010 13:54:45 -0700
Message-ID: <AANLkTi=y+5YXRwz2gDNfs9HAkRKro_Aw6eyUwTjcDt9M@mail.gmail.com>
References: <1289990661-30126-1-git-send-email-nsekhar@ti.com>
	<20101117152426.GA5757@angua.secretlab.ca>
	<B85A65D85D7EB246BE421B3FB0FBB5930247388244@dbde02.ent.ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59302473884F7@dbde02.ent.ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59302473885A3@dbde02.ent.ti.com>
	<4D0399EB.6070204@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <4D0399EB.6070204-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
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

On Sat, Dec 11, 2010 at 8:34 AM, Michael Williamson
<michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org> wrote:
> On 11/18/2010 08:14 AM, Nori, Sekhar wrote:
>> Hi Grant,
>>
>> On Thu, Nov 18, 2010 at 17:01:24, Nori, Sekhar wrote:
>>> On Thu, Nov 18, 2010 at 12:23:24, Nori, Sekhar wrote:
>>>>
>>>> Here is the pull request:
>>>>
>>>> The following changes since commit 0a5b871ea4c6bfb2723ac2ffc7ef5c32452=
abb89:
>>>> =A0 Linus Torvalds (1):
>>>> =A0 =A0 =A0 =A0 hardirq.h: remove now-empty #ifdef/#endif pair
>>>>
>>>> are available in the git repository at:
>>>>
>>>> =A0 git://arago-project.org/git/projects/linux-davinci.git for-grant
>>>>
>>>> <short log and diffstat deleted>
>>>
>>> Oops, I just realized that because my sign-off is added when
>>> git-format-patch -s is run, the patches in the pull request
>>> do not have my sign-off. I will recreate the branch with my
>>> sign-off added to these patches.
>>
>> I fixed this now. You can go ahead and do the pull.
>>
>> Thanks,
>> Sekhar
>>
>
> I was wondering is this has been / will be queued or if there were issues=
 holding
> it off? =A0If it has, what version?
>
> I have some patches that are dependent on this series that I have some ti=
me coming
> up to work on submission. =A0Apologies for the nag, Grant, if it's in pro=
cess.

Yes, stuff is in progress.  I hit a personal scalability issue which
has delayed getting a lot of my maintainership backlog sorted out.
Mostly due to the fact that it takes a lot of work to test my tree
before pushing it out.  I'm in the process of bringing up autotest so
that I have to manually test every platform before pushing my tree
into linux-next.

Patches should be sorted out next week since I've dedicated the week
to doing maintainership tasks.

g.
