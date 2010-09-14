From: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v5 1/1] davinci: spi: replace existing driver
Date: Tue, 14 Sep 2010 18:56:30 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301F6DF50C1@dbde02.ent.ti.com>
References: <1280355490-11878-1-git-send-email-bniebuhr@efjohnson.com>
	<4C8EB795.1080607@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6DF4C95@dbde02.ent.ti.com>
	<201009140904.59555.caglarakyuz@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6DF4D9B@dbde02.ent.ti.com>
	<4C8F7460.6050006@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
To: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <4C8F7460.6050006-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
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

Hi Mike,

On Tue, Sep 14, 2010 at 18:40:56, Michael Williamson wrote:
> On 9/14/2010 3:14 AM, Nori, Sekhar wrote:
>
> > On Tue, Sep 14, 2010 at 11:34:59, Caglar Akyuz wrote:
> >
> >> Yes, your patches seems ok and mostly complete. I'm waiting for hardware to
> >> test those, will let you know when I do some testing.
> >
> > Thanks! To save time, I haven't tested these patches myself. I have only made
> > sure individual patches don't break the build. Was planning to test after
> > the complete series is ready.
> >
>
>
> If it would help, If there are portions of the patch set that can be tested
> with DMA disabled or something, I'd be willing to kick the tires.  I have
> da850 hardware available.

Thanks for being brave and offering to help! Yes, interrupt and polled mode
can be tried. Since a lot of testing has already happened on the original patch,
I was planning to test the series only after it is complete. Any issues found can
be narrowed down to the differences (which I hope will be justifiable).

Thanks,
Sekhar
