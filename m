From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v5 1/1] davinci: spi: replace existing driver
Date: Tue, 3 Aug 2010 01:33:55 -0600
Message-ID: <AANLkTik99cgA83iOZPbidri000Lg2u-YCPUHU9PS5-=U@mail.gmail.com>
References: <1280355490-11878-1-git-send-email-bniebuhr@efjohnson.com>
	<1280355490-11878-2-git-send-email-bniebuhr@efjohnson.com>
	<AANLkTimu+G-5wTrdQ6YiWi60i+5uN9sydfsZKMKQX7_f@mail.gmail.com>
	<AANLkTim-FB6YrGSTmDQhmnS+Qw-dGm7D-pH7iCzy0-Td@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <AANLkTim-FB6YrGSTmDQhmnS+Qw-dGm7D-pH7iCzy0-Td-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Mon, Aug 2, 2010 at 8:10 AM, Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Grant -
>
> That's fine - I understand your position. =A0I do wish you had decided
> earlier that you weren't going to accept the patch in that form though
> so I could have decided whether I wanted to spend any more time on it.
> =A0For my part, I've already sunk way more time into this than I ever
> intended, and I really have no clue how to break this patch down into
> smaller patches. =A0I don't really care much if the patch gets accepted
> or not - I am just trying to help out all of the other users that are
> stuck with a broken driver like I was.

Hi Brian.  I'm sorry to hear that, but I totally understand having
heavy demands on your time.  Thanks for the work that you have done.
I know it is frustrating when things don't go in as easily as hoped.
I also want to see your changes merged, but I also have to be mindful
of other engineers looking at your commit after the fact and being
able to bisect it.

If you do change your mind, my offer still stands to help you break
the patch down into logical pieces.  It is actually pretty easy to do.

>=A0Maybe if TI wants to give
> their customers a driver that actually works they'll pick it up and do
> the rest of the work that's necessary to get it accepted. =A0I'm just
> way too swamped with other work to keep going on this.
>
> Thanks for your help though. =A0Sorry to waste all of the time you've
> put into this.

It hasn't been wasted time.  You've done all the hard work.  Sounds
like Sekhar from TI will pick up the driver and split it up, which is
an almost mechanical process when you know how to do it.  Thanks for
the time you have spent on this.

Cheers,
g.
