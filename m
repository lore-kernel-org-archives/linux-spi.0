From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 01/12] misc: add driver for sequencer serial port
Date: Mon, 18 Oct 2010 08:59:20 -0600
Message-ID: <AANLkTimZm6T_WywkekkoFepHJk72EC9wRVXxJFHkspHO@mail.gmail.com>
References: <1287081535-2864-1-git-send-email-cyril@ti.com>
	<1287081535-2864-2-git-send-email-cyril@ti.com>
	<20101016050055.GH21170@angua.secretlab.ca>
	<4CBC520B.9070502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
        "broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
        "dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        "lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org" <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
To: cyril-l0cyMroinI0@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <4CBC520B.9070502-l0cyMroinI0@public.gmane.org>
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

On Mon, Oct 18, 2010 at 7:56 AM, Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org> wrote:
> Hi Grant,
>
> Thanks for the feedback, I will send out an updated v2 with the proposed
> changes.
>
> [...]
>>> +EXPORT_SYMBOL(ti_ssp_open);
>>
>> I'm not thrilled with the ti_ssp_open()/ti_ssp_close() usage model.
>> It appears that the usage model is the board code registers an pile
>> of platform_devices, one for the ssp, and one for each of the
>> behaviours on top of it. =A0Then the various driver instances have to
>> figure out how to find each other and whether or not they are related.
>> Am I correct?
>>
>> Rather than doing an end-run around the Linux driver model, I strongly
>> recommend using the model to solve your problem. =A0Register only the
>> ssp platform_device in the board support code and pass it data about
>> the intended behaviour (via platform data). =A0When it gets probed, it
>> can then register additional platform devices which will get probed by
>> the requested driver. =A0That way the specific ssp device instance data
>> can be passed reliably to the spi/i2c/whatever driver without any
>> ambiguity, without any uncertainty about whether a port is 'busy', and
>> without the need of these open/close routines.
>>
>> (Hint: The trick is to set the platform_device's pdev->dev.parent
>> pointer to make use of the Linux device model's hierarchy).
>
> I am not very thrilled with this approach either :-) =A0I had looked at a
> few other instances where something similar was being done (spi, i2c,
> mdio, etc.), but felt that defining a new bus type would be an overkill
> for this.

Nope!  you don't need to define a new bus type.  Just continue to use
platform bus.  If you set the dev->parent pointer before registering
the device then the device model with have the appropriate hierarchy.

> For reference, could you please point me to some other place where
> something similar is being done?

Most of the multifunction devices operating in this way (though those
implementations are probably more convoluted than they need to be.
Take a look.  If you still have trouble with it let me know and I'll
draft an example for you.

g.
