From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 1/8] hwspinlock: Add one new API to support getting a
 specific hwlock by the name
Date: Wed, 27 Jun 2018 10:18:11 +0800
Message-ID: <CAMz4kuJ8OVjV+m-RHhOBDB5RchGm5gjOcXL=g0YWtvc8zbAqYw@mail.gmail.com>
References: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
 <20180626205438.GG3206@builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180626205438.GG3206@builder>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 27 June 2018 at 04:54, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
> On Fri 22 Jun 01:08 PDT 2018, Baolin Wang wrote:
>
>> The hardware spinlock binding already supplied the 'hwlock-names' property
>> to match and get a specific hwlock, but did not supply one API for users
>> to get a specific hwlock by the hwlock name. So this patch introduces one
>> API to support this requirement.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>
> Thanks Baolin,
>
> Picked up all but patch 6 from the series; including 7 and 8 with Mark's
> ack.

OK. Thanks Bjorn and Mark.

-- 
Baolin.wang
Best Regards
