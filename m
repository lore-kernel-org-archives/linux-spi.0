From: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v5 1/1] davinci: spi: replace existing driver
Date: Tue, 12 Oct 2010 17:44:27 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593023436368A@dbde02.ent.ti.com>
References: <1280355490-11878-1-git-send-email-bniebuhr@efjohnson.com>
	<4C8EB795.1080607@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6DF4C95@dbde02.ent.ti.com>
	<201009140904.59555.caglarakyuz@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6DF4D9B@dbde02.ent.ti.com>
	<4C8F7460.6050006@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6DF50C1@dbde02.ent.ti.com>
	<4C94B9BD.4010606@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6F5385B@dbde02.ent.ti.com>
	<4C979D1D.1070707@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB59302342050C7@dbde02.ent.ti.com>
	<4CAF6F86.40201@criticallink.com> <4CB0665A.3000309@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB59302343630D8@dbde02.ent.ti.com>
	<4CB352DF.70104@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
        Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <4CB352DF.70104-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Mike,

On Mon, Oct 11, 2010 at 23:39:35, Michael Williamson wrote:

> >
> > Hmm, looks like the Tx and Rx DMA must always run for the same duration. I was
> > under the impression Tx is required to keep the clock running, and so must always
> > run for the length of transfer requested, but Rx DMA can finish earlier.
> >
>
> That may be true.  The scenario I was seeing was a requested Tx length of 1 with no
> Rx buffer supplied.  The length of the internal buffer was bigger than 1, so the resulting
> Rx DMA size in the a_b_cnt was greater than the Tx size, and it stalled.
>
> > I guess replacing the line:
> >
> >                 param.a_b_cnt = rx_buf_count << 16 | data_type;
> >
> > with
> >
> >                 param.a_b_cnt = davinci_spi->rcount << 16 | data_type;
> >
> > will also fix the issue?
> >
>
> A better fix.  should be fine.

I tested this on DA830 and DA850 EVMs with SPI nor flash - it works fine.
I added your Tested-By to the DMA patches as well. Thanks for the testing
and bug fixing.

Updated set of patches pushed to my branch[1]. Testing on DM* platforms
is the next task.

Thanks,
Sekhar

[1] http://arago-project.org/git/projects/?p=linux-davinci.git;a=shortlog;h=refs/heads/davinci-spi-rewrite
